// Generated basic-flow test for the tokenize_read entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped TokenizeReadTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefinshieldconexsdk.core.{Config, Context, Helpers, SdkEntity, SdkError, BluefinShieldconexSDK}
import voxgig.bluefinshieldconexsdk.feature.BaseFeature
import voxgig.bluefinshieldconexsdk.utility.struct.Struct

object TokenizeReadEntityTest {

  import SdkTestSupport.{B, I, jl, om}

  private def hasFeature(name: String): Boolean = {
    val fm = Helpers.toMapAny(Config.sharedConfig().get("feature"))
    fm != null && fm.get(name) != null
  }

  def run(rep: SdkTestReport): Unit = {
    rep.scope("tokenize_read.instance") {
      val testsdk = BluefinShieldconexSDK.testSDK()
      val ent = testsdk.tokenizeRead(null)
      rep.check("tokenize_read.instance", ent != null, "expected non-null tokenize_read entity")
    }

    rep.scope("tokenize_read.validate") {
      if (hasFeature("validate")) {
        val client = BluefinShieldconexSDK.testSDK(null, om("feature" -> om("validate" -> om("active" -> B(true)))))
        val err = try {
          client.tokenizeRead(null).create(om("bfid" -> I(1)), null)
          null
        } catch { case e: SdkError => e }
        rep.check("tokenize_read.validate", err != null && "validate_failed" == err.code,
          "expected validate_failed, got " + err)
      }
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
      tokenizeReadRef01Data = Helpers.toMapAny(tokenizeReadRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("tokenize_read.create.map", tokenizeReadRef01Data != null, "expected create result to be a map")
    }
  }
}
