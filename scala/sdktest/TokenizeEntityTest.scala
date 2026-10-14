// Generated basic-flow test for the tokenize entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped TokenizeTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefinshieldconexsdk.core.{Config, Context, Helpers, SdkEntity, SdkError, BluefinShieldconexSDK}
import voxgig.bluefinshieldconexsdk.feature.BaseFeature
import voxgig.bluefinshieldconexsdk.utility.struct.Struct

object TokenizeEntityTest {

  import SdkTestSupport.{B, I, jl, om}

  private def hasFeature(name: String): Boolean = {
    val fm = Helpers.toMapAny(Config.sharedConfig().get("feature"))
    fm != null && fm.get(name) != null
  }

  final class FailHook extends BaseFeature("failhook", "0.0.1", true) {
    var unexpected = 0
    override def preSpec(ctx: Context): Unit = throw new RuntimeException("tokenize hook failed")
    override def preUnexpected(ctx: Context): Unit = unexpected += 1
  }

  def run(rep: SdkTestReport): Unit = {
    rep.scope("tokenize.instance") {
      val testsdk = BluefinShieldconexSDK.testSDK()
      val ent = testsdk.tokenize(null)
      rep.check("tokenize.instance", ent != null, "expected non-null tokenize entity")
    }

    rep.scope("tokenize.stream.error") {
      val offline = om("net" -> om("offline" -> B(true)))
      val err = try {
        BluefinShieldconexSDK.testSDK(offline, null).tokenize(null).stream("list", null, null).toList
        null
      } catch { case e: RuntimeException => e }
      rep.check("tokenize.stream.error", err != null && String.valueOf(err.getMessage).contains("offline"),
        "expected the transport failure to raise from the stream, got " + err)

      BluefinShieldconexSDK.testSDK(offline, null).tokenize(null)
        .stream("list", null, om("ctrl" -> om("throw" -> B(false)))).toList

      if (hasFeature("rbac")) {
        val denied = BluefinShieldconexSDK.testSDK(null,
          om("feature" -> om("rbac" -> om("active" -> B(true), "deny" -> B(true)))))
        val denyerr = try {
          denied.tokenize(null).stream("list", null, null).toList
          null
        } catch { case e: SdkError => e }
        rep.check("tokenize.stream.denied", denyerr != null && "rbac_denied" == denyerr.code,
          "expected the rbac denial to raise from the stream, got " + denyerr)
      }
    }

    rep.scope("tokenize.stream.ctrl") {
      val explain = new LinkedHashMap[String, Object]()
      val ctrl = om("explain" -> explain)
      BluefinShieldconexSDK.testSDK().tokenize(null).stream("list", null, om("ctrl" -> ctrl)).toList
      rep.check("tokenize.stream.ctrl", 1 == ctrl.size() && (explain eq ctrl.get("explain")),
        "the stream changed the caller's ctrl")
      rep.check("tokenize.stream.explain", !explain.isEmpty(), "the caller's explain record was not filled")
    }

    rep.scope("tokenize.unexpected") {
      val hook = new FailHook()
      val client = new BluefinShieldconexSDK(om("feature" -> om("test" -> om("active" -> B(true))), "extend" -> jl(hook)))
      val err = try {
        client.tokenize(null).list(null, null)
        null
      } catch { case e: RuntimeException => e }
      rep.check("tokenize.unexpected.raise", err != null && String.valueOf(err.getMessage).contains("hook failed"),
        "expected the hook's failure, got " + err)
      rep.check("tokenize.unexpected.fired", hook.unexpected > 0, "PreUnexpected did not fire")

      val fired = hook.unexpected
      client.tokenize(null).list(null, om("throw" -> B(false)))
      rep.check("tokenize.unexpected.nothrow", hook.unexpected > fired,
        "PreUnexpected did not fire under throw false")
    }

    rep.scope("tokenize.validate") {
      if (hasFeature("validate")) {
        val client = BluefinShieldconexSDK.testSDK(null, om("feature" -> om("validate" -> om("active" -> B(true)))))
        val err = try {
          client.tokenize(null).list(om("field_name" -> I(1), "template_ref" -> "x"), null)
          null
        } catch { case e: SdkError => e }
        rep.check("tokenize.validate", err != null && "validate_failed" == err.code,
          "expected validate_failed, got " + err)
      }
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
      tokenizeRef01Data = Helpers.toMapAny(tokenizeRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("tokenize.create.map", tokenizeRef01Data != null, "expected create result to be a map")

      // LIST
      val tokenizeRef01Match = new LinkedHashMap[String, Object]()
      val tokenizeRef01ListResult = tokenizeRef01Ent.list(tokenizeRef01Match, null)
      rep.check("tokenize.list.islist", tokenizeRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + tokenizeRef01ListResult)
    }
  }
}
