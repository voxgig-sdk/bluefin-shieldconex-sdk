// Generated basic-flow test for the tokenize_read entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped TokenizeReadTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefinshieldconexsdk.core.{Helpers, BluefinShieldconexSDK}
import voxgig.bluefinshieldconexsdk.utility.struct.Struct

object TokenizeReadEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("tokenize_read.instance") {
      val testsdk = BluefinShieldconexSDK.testSDK()
      val ent = testsdk.tokenizeRead(null)
      rep.check("tokenize_read.instance", ent != null, "expected non-null tokenize_read entity")
    }

    rep.scope("tokenize_read.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/tokenize_read/TokenizeReadTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = BluefinShieldconexSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("tokenize_read01", "TOKENIZE_READ01")
      idmap.put("tokenize_read02", "TOKENIZE_READ02")
      idmap.put("tokenize_read03", "TOKENIZE_READ03")
      val now = System.currentTimeMillis()

      // CREATE
      val tokenizeReadRef01Ent = client.tokenizeRead(null)
      var tokenizeReadRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.tokenize_read"), "tokenize_read_ref01"))
      val tokenizeReadRef01DataResult = tokenizeReadRef01Ent.create(tokenizeReadRef01Data, null)
      tokenizeReadRef01Data = Helpers.toMapAny(tokenizeReadRef01DataResult)
      rep.check("tokenize_read.create.map", tokenizeReadRef01Data != null, "expected create result to be a map")
    }
  }
}
