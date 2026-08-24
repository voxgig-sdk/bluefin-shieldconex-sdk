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
class ValidateEntityTest {

  @Test
  fun instance() {
    val testsdk = BluefinShieldconexSDK.testSDK()
    val ent = testsdk.validate(null)
    assertNotNull(ent, "expected non-null validate entity")
  }

  @Test
  fun basic() {
    val setup = validateBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("create")) {
      val reason = RunnerSupport.skipReason("entityOp", "validate.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val validateRef01Ent = client.validate(null)
    var validateRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.validate"), "validate_ref01")) ?: linkedMapOf())

    val validateRef01DataResult = validateRef01Ent.create(validateRef01Data, null)
    validateRef01Data = Helpers.toMapAny(if (validateRef01DataResult is SdkEntity) validateRef01DataResult.data() else validateRef01DataResult) ?: linkedMapOf()
    assertNotNull(validateRef01Data, "expected create result to be a map")

  }

  companion object {
    fun validateBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "validate", "ValidateTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read validate test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = BluefinShieldconexSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("validate01")
      idnames.add("validate02")
      idnames.add("validate03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID"] = idmap
      envm["BLUEFIN_SHIELDCONEX_TEST_LIVE"] = "FALSE"
      envm["BLUEFIN_SHIELDCONEX_TEST_EXPLAIN"] = "FALSE"
      envm["BLUEFIN_SHIELDCONEX_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID"])
      if (idmapResolved == null) {
        idmapResolved = Helpers.toMapAny(idmap) ?: linkedMapOf()
      }

      val live = "TRUE" == env["BLUEFIN_SHIELDCONEX_TEST_LIVE"]
      if (live) {
        val liveOpts = linkedMapOf<String, Any?>()
        liveOpts["apikey"] = env["BLUEFIN_SHIELDCONEX_APIKEY"]
        val mergedOpts = Struct.merge(Struct.jt(liveOpts, extra))
        client = BluefinShieldconexSDK(Helpers.toMapAny(mergedOpts))
      }

      val setup = RunnerSupport.EntityTestSetup()
      setup.client = client
      setup.data = entityData
      setup.idmap = idmapResolved
      setup.env = env
      setup.explain = "TRUE" == env["BLUEFIN_SHIELDCONEX_TEST_EXPLAIN"]
      setup.live = live
      setup.syntheticOnly = live && !idmapOverridden
      setup.now = System.currentTimeMillis()
      return setup
    }
  }
}
