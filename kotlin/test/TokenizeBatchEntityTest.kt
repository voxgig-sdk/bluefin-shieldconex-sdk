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
class TokenizeBatchEntityTest {

  @Test
  fun instance() {
    val testsdk = BluefinShieldconexSDK.testSDK()
    val ent = testsdk.tokenizeBatch(null)
    assertNotNull(ent, "expected non-null tokenize_batch entity")
  }

  @Test
  fun basic() {
    val setup = tokenizeBatchBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf("create")) {
      val reason = RunnerSupport.skipReason("entityOp", "tokenize_batch.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val tokenizeBatchRef01Ent = client.tokenizeBatch(null)
    var tokenizeBatchRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.tokenize_batch"), "tokenize_batch_ref01")) ?: linkedMapOf())

    val tokenizeBatchRef01DataResult = tokenizeBatchRef01Ent.create(tokenizeBatchRef01Data, null)
    tokenizeBatchRef01Data = Helpers.toMapAny(tokenizeBatchRef01DataResult) ?: linkedMapOf()
    assertNotNull(tokenizeBatchRef01Data, "expected create result to be a map")

  }

  companion object {
    fun tokenizeBatchBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "tokenize_batch", "TokenizeBatchTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read tokenize_batch test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = BluefinShieldconexSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("tokenize_batch01")
      idnames.add("tokenize_batch02")
      idnames.add("tokenize_batch03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID"] = idmap
      envm["BLUEFINSHIELDCONEX_TEST_LIVE"] = "FALSE"
      envm["BLUEFINSHIELDCONEX_TEST_EXPLAIN"] = "FALSE"
      envm["BLUEFINSHIELDCONEX_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID"])
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
