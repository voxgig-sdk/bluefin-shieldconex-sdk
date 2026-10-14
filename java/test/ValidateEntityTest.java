package voxgig.bluefinshieldconexsdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
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

import voxgig.bluefinshieldconexsdk.core.Config;
import voxgig.bluefinshieldconexsdk.core.Context;
import voxgig.bluefinshieldconexsdk.core.Helpers;
import voxgig.bluefinshieldconexsdk.core.SdkEntity;
import voxgig.bluefinshieldconexsdk.core.SdkError;
import voxgig.bluefinshieldconexsdk.core.BluefinShieldconexSDK;
import voxgig.bluefinshieldconexsdk.feature.BaseFeature;
import voxgig.bluefinshieldconexsdk.utility.Json;
import voxgig.bluefinshieldconexsdk.utility.struct.Struct;

@SuppressWarnings({"unchecked", "unused"})
public class ValidateEntityTest {

  // main.kit.test.live.strict is true (the default is true): a live
  // request that fails, or a live test missing an input it needs,
  // fails the test.
  // An account with no record for a test to read skips it either way.
  static final boolean LIVE_STRICT = true;

  @Test
  public void instance() {
    BluefinShieldconexSDK testsdk = BluefinShieldconexSDK.testSDK();
    SdkEntity ent = testsdk.validate(null);
    assertNotNull(ent, "expected non-null validate entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = validateBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "create" }) {
      String reason = RunnerSupport.skipReason("entityOp", "validate." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    BluefinShieldconexSDK client = setup.client;

    // CREATE
    SdkEntity validateRef01Ent = client.validate(null);
    Map<String, Object> validateRef01Data = Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.validate"), "validate_ref01"));

    Object validateRef01DataResult = validateRef01Ent.create(validateRef01Data, null);
    validateRef01Data = Helpers.toMapAny(validateRef01DataResult instanceof SdkEntity ? ((SdkEntity) validateRef01DataResult).data() : validateRef01DataResult);
    assertNotNull(validateRef01Data, "expected create result to be a map");

  }

  static boolean hasFeature(String name) {
    Map<String, Object> fm = Helpers.toMapAny(Config.makeConfig().get("feature"));
    return fm != null && fm.get(name) != null;
  }

  @Test
  public void validate() {
    Assumptions.assumeTrue(hasFeature("validate"), "feature not present in this SDK: validate");
    BluefinShieldconexSDK client = BluefinShieldconexSDK.testSDK(null,
        Struct.jm("feature", Struct.jm("validate", Struct.jm("active", true))));
    SdkError err = assertThrows(SdkError.class, () ->
        client.validate(null).create(Struct.jm("messageId", 1, "templateRef", "x"), null));
    assertEquals("validate_failed", err.code);
  }

  static RunnerSupport.EntityTestSetup validateBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "validate", "ValidateTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read validate test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    BluefinShieldconexSDK client = BluefinShieldconexSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("validate01");
    idnames.add("validate02");
    idnames.add("validate03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Whether *_ENTID supplied the idmap, read before envOverride consumes
    // it: without it, the ids a live flow binds are the fixture's synthetic ones.
    String entidEnvRaw = RunnerSupport.getenv("BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID", idmap);
    envm.put("BLUEFIN_SHIELDCONEX_TEST_LIVE", "FALSE");
    envm.put("BLUEFIN_SHIELDCONEX_TEST_EXPLAIN", "FALSE");
    envm.put("BLUEFIN_SHIELDCONEX_APIKEY", "");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID"));
    if (idmapResolved == null) {
      idmapResolved = Helpers.toMapAny(idmap);
    }

    boolean live = "TRUE".equals(env.get("BLUEFIN_SHIELDCONEX_TEST_LIVE"));
    if (live) {
      // sdk-test-control.json's test.client.options seeds the live
      // client; the generated fields below overwrite anything they name.
      Map<String, Object> liveOpts =
          new LinkedHashMap<>(RunnerSupport.liveClientOptions());
      liveOpts.put("apikey", env.get("BLUEFIN_SHIELDCONEX_APIKEY"));
      // An empty map, not a null one: merge answers null when its last
      // entry is null, and basicSetup is normally called with no extras -
      // so a bare null silently discarded the apikey and server values
      // above.
      Map<String, Object> extraOpts =
          extra == null ? new LinkedHashMap<>() : extra;
      Object mergedOpts = Struct.merge(Struct.jt(liveOpts, extraOpts));
      client = new BluefinShieldconexSDK(Helpers.toMapAny(mergedOpts));
    }

    RunnerSupport.EntityTestSetup setup = new RunnerSupport.EntityTestSetup();
    setup.client = client;
    setup.data = entityData;
    setup.idmap = idmapResolved;
    setup.env = env;
    setup.explain = "TRUE".equals(env.get("BLUEFIN_SHIELDCONEX_TEST_EXPLAIN"));
    setup.live = live;
    setup.syntheticOnly = live && !idmapOverridden;
    setup.now = System.currentTimeMillis();
    return setup;
  }
}
