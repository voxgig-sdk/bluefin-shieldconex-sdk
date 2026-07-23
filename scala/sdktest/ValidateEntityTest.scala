// Generated basic-flow test for the validate entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped ValidateTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefinshieldconexsdk.core.{Helpers, BluefinShieldconexSDK}
import voxgig.bluefinshieldconexsdk.utility.struct.Struct

object ValidateEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("validate.instance") {
      val testsdk = BluefinShieldconexSDK.testSDK()
      val ent = testsdk.validate(null)
      rep.check("validate.instance", ent != null, "expected non-null validate entity")
    }

    rep.scope("validate.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/validate/ValidateTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = BluefinShieldconexSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("validate01", "VALIDATE01")
      idmap.put("validate02", "VALIDATE02")
      idmap.put("validate03", "VALIDATE03")
      val now = System.currentTimeMillis()

      // CREATE
      val validateRef01Ent = client.validate(null)
      var validateRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.validate"), "validate_ref01"))
      val validateRef01DataResult = validateRef01Ent.create(validateRef01Data, null)
      validateRef01Data = Helpers.toMapAny(validateRef01DataResult)
      rep.check("validate.create.map", validateRef01Data != null, "expected create result to be a map")
    }
  }
}
