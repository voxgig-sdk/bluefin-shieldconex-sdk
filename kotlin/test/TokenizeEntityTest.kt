package voxgig.bluefinshieldconexsdk.sdktest

import java.nio.file.Files
import java.nio.file.Paths

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Assumptions
import org.junit.jupiter.api.Test

import voxgig.bluefinshieldconexsdk.core.Helpers
import voxgig.bluefinshieldconexsdk.core.SdkEntity
import voxgig.bluefinshieldconexsdk.core.BluefinShieldconexSDK
import voxgig.bluefinshieldconexsdk.utility.Json
import voxgig.bluefinshieldconexsdk.utility.struct.Struct

@Suppress("UNCHECKED_CAST", "UNUSED_VARIABLE", "UNUSED_VALUE")
class TokenizeEntityTest {

  @Test
  fun instance() {
    val testsdk = BluefinShieldconexSDK.testSDK()
    val ent = testsdk.tokenize(null)
    assertNotNull(ent, "expected non-null tokenize entity")
  }

  @Test
  fun basic() {
    val setup = tokenizeBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf("create", "list")) {
      val reason = RunnerSupport.skipReason("entityOp", "tokenize.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val tokenizeRef01Ent = client.tokenize(null)
    var tokenizeRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.tokenize"), "tokenize_ref01")) ?: linkedMapOf())

    val tokenizeRef01DataResult = tokenizeRef01Ent.create(tokenizeRef01Data, null)
    tokenizeRef01Data = Helpers.toMapAny(tokenizeRef01DataResult) ?: linkedMapOf()
    assertNotNull(tokenizeRef01Data, "expected create result to be a map")

    // LIST
    val tokenizeRef01Match = linkedMapOf<String, Any?>()

    val tokenizeRef01ListResult = tokenizeRef01Ent.list(tokenizeRef01Match, null)
    assertTrue(tokenizeRef01ListResult is List<*>,
        "expected list result to be an array, got " + tokenizeRef01ListResult)
    val tokenizeRef01List = tokenizeRef01ListResult as List<Any?>

    val foundItem = Struct.select(
        RunnerSupport.entityListToData(tokenizeRef01List),
        Struct.jm("id", tokenizeRef01Data["id"]))
    assertFalse(Struct.isempty(foundItem), "expected to find created entity in list")

  }

  @Test
  fun stream() {
    val streamingActive = linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "streaming" to linkedMapOf<String, Any?>("active" to true),
      ),
    )
    val setup = tokenizeBasicSetup(streamingActive)
    Assumptions.assumeFalse(
      setup.live,
      "stream test streams the seeded fixture data (unit mode only)",
    )

    val ent = setup.client.tokenize(null)
    val match = linkedMapOf<String, Any?>()

    // Materialised list result for the same op.
    val listedResult = ent.list(match, null)
    val listed = (listedResult as? List<Any?>) ?: emptyList<Any?>()

    // stream("list") yields items via the streaming feature's iterator.
    val streamed = ent.stream("list", match, null).toList()
    assertTrue(streamed.size > 0, "expected stream to yield items")
    assertEquals(listed.size, streamed.size, "expected stream to match list count")

    // Fallback: with streaming inactive, stream still yields the materialised
    // items.
    val setup2 = tokenizeBasicSetup(null)
    val ent2 = setup2.client.tokenize(null)
    val streamed2 = ent2.stream("list", match, null).toList()
    assertEquals(listed.size, streamed2.size, "expected fallback stream to match list")
  }

  companion object {
    fun tokenizeBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "tokenize", "TokenizeTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read tokenize test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = BluefinShieldconexSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("tokenize01")
      idnames.add("tokenize02")
      idnames.add("tokenize03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID"] = idmap
      envm["BLUEFINSHIELDCONEX_TEST_LIVE"] = "FALSE"
      envm["BLUEFINSHIELDCONEX_TEST_EXPLAIN"] = "FALSE"
      envm["BLUEFINSHIELDCONEX_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID"])
      if (idmapResolved == null) {
        idmapResolved = Helpers.toMapAny(idmap) ?: linkedMapOf()
      }

      val live = "TRUE" == env["BLUEFINSHIELDCONEX_TEST_LIVE"]
      if (live) {
        val liveOpts = linkedMapOf<String, Any?>()
        liveOpts["apikey"] = env["BLUEFINSHIELDCONEX_APIKEY"]
        val mergedOpts = Struct.merge(Struct.jt(liveOpts, extra))
        client = BluefinShieldconexSDK(Helpers.toMapAny(mergedOpts))
      }

      val setup = RunnerSupport.EntityTestSetup()
      setup.client = client
      setup.data = entityData
      setup.idmap = idmapResolved
      setup.env = env
      setup.explain = "TRUE" == env["BLUEFINSHIELDCONEX_TEST_EXPLAIN"]
      setup.live = live
      setup.syntheticOnly = live && !idmapOverridden
      setup.now = System.currentTimeMillis()
      return setup
    }
  }
}
