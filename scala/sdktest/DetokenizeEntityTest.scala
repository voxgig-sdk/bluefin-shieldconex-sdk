// Generated basic-flow test for the detokenize entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped DetokenizeTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefinshieldconexsdk.core.{Helpers, BluefinShieldconexSDK}
import voxgig.bluefinshieldconexsdk.utility.struct.Struct

object DetokenizeEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("detokenize.instance") {
      val testsdk = BluefinShieldconexSDK.testSDK()
      val ent = testsdk.detokenize(null)
      rep.check("detokenize.instance", ent != null, "expected non-null detokenize entity")
    }

    rep.scope("detokenize.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/detokenize/DetokenizeTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = BluefinShieldconexSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("detokenize01", "DETOKENIZE01")
      idmap.put("detokenize02", "DETOKENIZE02")
      idmap.put("detokenize03", "DETOKENIZE03")
      val now = System.currentTimeMillis()

      // CREATE
      val detokenizeRef01Ent = client.detokenize(null)
      var detokenizeRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.detokenize"), "detokenize_ref01"))
      val detokenizeRef01DataResult = detokenizeRef01Ent.create(detokenizeRef01Data, null)
      detokenizeRef01Data = Helpers.toMapAny(detokenizeRef01DataResult)
      rep.check("detokenize.create.map", detokenizeRef01Data != null, "expected create result to be a map")

      // LIST
      val detokenizeRef01Match = new LinkedHashMap[String, Object]()
      val detokenizeRef01ListResult = detokenizeRef01Ent.list(detokenizeRef01Match, null)
      rep.check("detokenize.list.islist", detokenizeRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + detokenizeRef01ListResult)
      val detokenizeRef01List = detokenizeRef01ListResult.asInstanceOf[JList[Object]]
      val detokenizeRef01ListFound = Struct.select(
          SdkTestSupport.entityListToData(detokenizeRef01List), SdkTestSupport.om("id" -> detokenizeRef01Data.get("id")))
      rep.check("detokenize.list.exists", !Struct.isempty(detokenizeRef01ListFound), "expected to find created entity in list")
    }
  }
}
