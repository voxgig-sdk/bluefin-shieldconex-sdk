// Generated basic-flow test for the tokenize_batch entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped TokenizeBatchTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefinshieldconexsdk.core.{Helpers, BluefinShieldconexSDK}
import voxgig.bluefinshieldconexsdk.utility.struct.Struct

object TokenizeBatchEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("tokenize_batch.instance") {
      val testsdk = BluefinShieldconexSDK.testSDK()
      val ent = testsdk.tokenizeBatch(null)
      rep.check("tokenize_batch.instance", ent != null, "expected non-null tokenize_batch entity")
    }

    rep.scope("tokenize_batch.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/tokenize_batch/TokenizeBatchTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = BluefinShieldconexSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("tokenize_batch01", "TOKENIZE_BATCH01")
      idmap.put("tokenize_batch02", "TOKENIZE_BATCH02")
      idmap.put("tokenize_batch03", "TOKENIZE_BATCH03")
      val now = System.currentTimeMillis()

      // CREATE
      val tokenizeBatchRef01Ent = client.tokenizeBatch(null)
      var tokenizeBatchRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.tokenize_batch"), "tokenize_batch_ref01"))
      val tokenizeBatchRef01DataResult = tokenizeBatchRef01Ent.create(tokenizeBatchRef01Data, null)
      tokenizeBatchRef01Data = Helpers.toMapAny(tokenizeBatchRef01DataResult)
      rep.check("tokenize_batch.create.map", tokenizeBatchRef01Data != null, "expected create result to be a map")
    }
  }
}
