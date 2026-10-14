// Generated basic-flow test for the detokenize entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped DetokenizeTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefinshieldconexsdk.core.{Config, Context, Helpers, SdkEntity, SdkError, BluefinShieldconexSDK}
import voxgig.bluefinshieldconexsdk.feature.BaseFeature
import voxgig.bluefinshieldconexsdk.utility.struct.Struct

object DetokenizeEntityTest {

  import SdkTestSupport.{B, I, jl, om}

  private def hasFeature(name: String): Boolean = {
    val fm = Helpers.toMapAny(Config.sharedConfig().get("feature"))
    fm != null && fm.get(name) != null
  }

  final class FailHook extends BaseFeature("failhook", "0.0.1", true) {
    var unexpected = 0
    override def preSpec(ctx: Context): Unit = throw new RuntimeException("detokenize hook failed")
    override def preUnexpected(ctx: Context): Unit = unexpected += 1
  }

  def run(rep: SdkTestReport): Unit = {
    rep.scope("detokenize.instance") {
      val testsdk = BluefinShieldconexSDK.testSDK()
      val ent = testsdk.detokenize(null)
      rep.check("detokenize.instance", ent != null, "expected non-null detokenize entity")
    }

    rep.scope("detokenize.stream.error") {
      val offline = om("net" -> om("offline" -> B(true)))
      val err = try {
        BluefinShieldconexSDK.testSDK(offline, null).detokenize(null).stream("list", null, null).toList
        null
      } catch { case e: RuntimeException => e }
      rep.check("detokenize.stream.error", err != null && String.valueOf(err.getMessage).contains("offline"),
        "expected the transport failure to raise from the stream, got " + err)

      BluefinShieldconexSDK.testSDK(offline, null).detokenize(null)
        .stream("list", null, om("ctrl" -> om("throw" -> B(false)))).toList

      if (hasFeature("rbac")) {
        val denied = BluefinShieldconexSDK.testSDK(null,
          om("feature" -> om("rbac" -> om("active" -> B(true), "deny" -> B(true)))))
        val denyerr = try {
          denied.detokenize(null).stream("list", null, null).toList
          null
        } catch { case e: SdkError => e }
        rep.check("detokenize.stream.denied", denyerr != null && "rbac_denied" == denyerr.code,
          "expected the rbac denial to raise from the stream, got " + denyerr)
      }
    }

    rep.scope("detokenize.stream.ctrl") {
      val explain = new LinkedHashMap[String, Object]()
      val ctrl = om("explain" -> explain)
      BluefinShieldconexSDK.testSDK().detokenize(null).stream("list", null, om("ctrl" -> ctrl)).toList
      rep.check("detokenize.stream.ctrl", 1 == ctrl.size() && (explain eq ctrl.get("explain")),
        "the stream changed the caller's ctrl")
      rep.check("detokenize.stream.explain", !explain.isEmpty(), "the caller's explain record was not filled")
    }

    rep.scope("detokenize.unexpected") {
      val hook = new FailHook()
      val client = new BluefinShieldconexSDK(om("feature" -> om("test" -> om("active" -> B(true))), "extend" -> jl(hook)))
      val err = try {
        client.detokenize(null).list(null, null)
        null
      } catch { case e: RuntimeException => e }
      rep.check("detokenize.unexpected.raise", err != null && String.valueOf(err.getMessage).contains("hook failed"),
        "expected the hook's failure, got " + err)
      rep.check("detokenize.unexpected.fired", hook.unexpected > 0, "PreUnexpected did not fire")

      val fired = hook.unexpected
      client.detokenize(null).list(null, om("throw" -> B(false)))
      rep.check("detokenize.unexpected.nothrow", hook.unexpected > fired,
        "PreUnexpected did not fire under throw false")
    }

    rep.scope("detokenize.validate") {
      if (hasFeature("validate")) {
        val client = BluefinShieldconexSDK.testSDK(null, om("feature" -> om("validate" -> om("active" -> B(true)))))
        val err = try {
          client.detokenize(null).list(om("bfid" -> I(1)), null)
          null
        } catch { case e: SdkError => e }
        rep.check("detokenize.validate", err != null && "validate_failed" == err.code,
          "expected validate_failed, got " + err)
      }
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
      detokenizeRef01Data = Helpers.toMapAny(detokenizeRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("detokenize.create.map", detokenizeRef01Data != null, "expected create result to be a map")

      // LIST
      val detokenizeRef01Match = new LinkedHashMap[String, Object]()
      val detokenizeRef01ListResult = detokenizeRef01Ent.list(detokenizeRef01Match, null)
      rep.check("detokenize.list.islist", detokenizeRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + detokenizeRef01ListResult)
    }
  }
}
