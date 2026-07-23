// Generated basic-flow test for the tokenize entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped TokenizeTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefinshieldconexsdk.core.{Helpers, BluefinShieldconexSDK}
import voxgig.bluefinshieldconexsdk.utility.struct.Struct

object TokenizeEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("tokenize.instance") {
      val testsdk = BluefinShieldconexSDK.testSDK()
      val ent = testsdk.tokenize(null)
      rep.check("tokenize.instance", ent != null, "expected non-null tokenize entity")
    }

    rep.scope("tokenize.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/tokenize/TokenizeTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = BluefinShieldconexSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("tokenize01", "TOKENIZE01")
      idmap.put("tokenize02", "TOKENIZE02")
      idmap.put("tokenize03", "TOKENIZE03")
      val now = System.currentTimeMillis()

      // CREATE
      val tokenizeRef01Ent = client.tokenize(null)
      var tokenizeRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.tokenize"), "tokenize_ref01"))
      val tokenizeRef01DataResult = tokenizeRef01Ent.create(tokenizeRef01Data, null)
      tokenizeRef01Data = Helpers.toMapAny(tokenizeRef01DataResult)
      rep.check("tokenize.create.map", tokenizeRef01Data != null, "expected create result to be a map")

      // LIST
      val tokenizeRef01Match = new LinkedHashMap[String, Object]()
      val tokenizeRef01ListResult = tokenizeRef01Ent.list(tokenizeRef01Match, null)
      rep.check("tokenize.list.islist", tokenizeRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + tokenizeRef01ListResult)
      val tokenizeRef01List = tokenizeRef01ListResult.asInstanceOf[JList[Object]]
      val tokenizeRef01ListFound = Struct.select(
          SdkTestSupport.entityListToData(tokenizeRef01List), SdkTestSupport.om("id" -> tokenizeRef01Data.get("id")))
      rep.check("tokenize.list.exists", !Struct.isempty(tokenizeRef01ListFound), "expected to find created entity in list")
    }
  }
}
