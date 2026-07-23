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
class TokenizeReadEntityTest {

  @Test
  fun instance() {
    val testsdk = BluefinShieldconexSDK.testSDK()
    val ent = testsdk.tokenizeRead(null)
    assertNotNull(ent, "expected non-null tokenize_read entity")
  }

  @Test
  fun basic() {
    val setup = tokenizeReadBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf("create")) {
      val reason = RunnerSupport.skipReason("entityOp", "tokenize_read.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set BLUEFINSHIELDCONEX_TEST_TOKENIZE_READ_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val tokenizeReadRef01Ent = client.tokenizeRead(null)
    var tokenizeReadRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.tokenize_read"), "tokenize_read_ref01")) ?: linkedMapOf())

    val tokenizeReadRef01DataResult = tokenizeReadRef01Ent.create(tokenizeReadRef01Data, null)
    tokenizeReadRef01Data = Helpers.toMapAny(tokenizeReadRef01DataResult) ?: linkedMapOf()
    assertNotNull(tokenizeReadRef01Data, "expected create result to be a map")

  }

  companion object {
    fun tokenizeReadBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "tokenize_read", "TokenizeReadTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read tokenize_read test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = BluefinShieldconexSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("tokenize_read01")
      idnames.add("tokenize_read02")
      idnames.add("tokenize_read03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("BLUEFINSHIELDCONEX_TEST_TOKENIZE_READ_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["BLUEFINSHIELDCONEX_TEST_TOKENIZE_READ_ENTID"] = idmap
      envm["BLUEFINSHIELDCONEX_TEST_LIVE"] = "FALSE"
      envm["BLUEFINSHIELDCONEX_TEST_EXPLAIN"] = "FALSE"
      envm["BLUEFINSHIELDCONEX_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["BLUEFINSHIELDCONEX_TEST_TOKENIZE_READ_ENTID"])
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
