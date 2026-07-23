package voxgig.bluefinshieldconexsdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.Test;

import voxgig.bluefinshieldconexsdk.core.Helpers;
import voxgig.bluefinshieldconexsdk.core.SdkEntity;
import voxgig.bluefinshieldconexsdk.core.BluefinShieldconexSDK;
import voxgig.bluefinshieldconexsdk.utility.Json;
import voxgig.bluefinshieldconexsdk.utility.struct.Struct;

@SuppressWarnings({"unchecked", "unused"})
public class TokenizeReadEntityTest {

  @Test
  public void instance() {
    BluefinShieldconexSDK testsdk = BluefinShieldconexSDK.testSDK();
    SdkEntity ent = testsdk.tokenizeRead(null);
    assertNotNull(ent, "expected non-null tokenize_read entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = tokenizeReadBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "create" }) {
      String reason = RunnerSupport.skipReason("entityOp", "tokenize_read." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    Assumptions.assumeFalse(setup.syntheticOnly,
        "live entity test uses synthetic IDs from fixture — set BLUEFINSHIELDCONEX_TEST_TOKENIZE_READ_ENTID JSON to run live");
    BluefinShieldconexSDK client = setup.client;

    // CREATE
    SdkEntity tokenizeReadRef01Ent = client.tokenizeRead(null);
    Map<String, Object> tokenizeReadRef01Data = Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.tokenize_read"), "tokenize_read_ref01"));

    Object tokenizeReadRef01DataResult = tokenizeReadRef01Ent.create(tokenizeReadRef01Data, null);
    tokenizeReadRef01Data = Helpers.toMapAny(tokenizeReadRef01DataResult);
    assertNotNull(tokenizeReadRef01Data, "expected create result to be a map");

  }

  static RunnerSupport.EntityTestSetup tokenizeReadBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "tokenize_read", "TokenizeReadTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read tokenize_read test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    BluefinShieldconexSDK client = BluefinShieldconexSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("tokenize_read01");
    idnames.add("tokenize_read02");
    idnames.add("tokenize_read03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's. Surface this so the test
    // can skip.
    String entidEnvRaw = RunnerSupport.getenv("BLUEFINSHIELDCONEX_TEST_TOKENIZE_READ_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("BLUEFINSHIELDCONEX_TEST_TOKENIZE_READ_ENTID", idmap);
    envm.put("BLUEFINSHIELDCONEX_TEST_LIVE", "FALSE");
    envm.put("BLUEFINSHIELDCONEX_TEST_EXPLAIN", "FALSE");
    envm.put("BLUEFINSHIELDCONEX_APIKEY", "NONE");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("BLUEFINSHIELDCONEX_TEST_TOKENIZE_READ_ENTID"));
    if (idmapResolved == null) {
      idmapResolved = Helpers.toMapAny(idmap);
    }

    boolean live = "TRUE".equals(env.get("BLUEFINSHIELDCONEX_TEST_LIVE"));
    if (live) {
      Map<String, Object> liveOpts = new LinkedHashMap<>();
      liveOpts.put("apikey", env.get("BLUEFINSHIELDCONEX_APIKEY"));
      Object mergedOpts = Struct.merge(Struct.jt(liveOpts, extra));
      client = new BluefinShieldconexSDK(Helpers.toMapAny(mergedOpts));
    }

    RunnerSupport.EntityTestSetup setup = new RunnerSupport.EntityTestSetup();
    setup.client = client;
    setup.data = entityData;
    setup.idmap = idmapResolved;
    setup.env = env;
    setup.explain = "TRUE".equals(env.get("BLUEFINSHIELDCONEX_TEST_EXPLAIN"));
    setup.live = live;
    setup.syntheticOnly = live && !idmapOverridden;
    setup.now = System.currentTimeMillis();
    return setup;
  }
}
