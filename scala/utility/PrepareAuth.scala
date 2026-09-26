package voxgig.bluefinshieldconexsdk.utility

import java.nio.charset.StandardCharsets
import java.util.Base64

import voxgig.bluefinshieldconexsdk.core.{Context, Spec}
import voxgig.bluefinshieldconexsdk.utility.struct.Struct

// Places the credential as the `authorization` request header.
// GENERATED from the API's security scheme (main.kit.info.security:
// in: header, name: authorization, http basic).
object PrepareAuth {
  val CRED_NAME = "authorization"
  val OPTION_APIKEY = "apikey"
  val OPTION_SECRET = "secret"
  val NOT_FOUND = "__NOTFOUND__"

  def prepareAuth(ctx: Context): Spec = {
    val spec = ctx.spec
    if (spec == null) throw ctx.makeError("auth_no_spec", "Expected context spec property to be defined.")

    val headers = spec.headers
    val options = ctx.client.optionsMap()

    // Public APIs that need no auth omit the options.auth block entirely.
    if (options.get("auth") == null) {
      headers.remove(CRED_NAME)
      return spec
    }

    val apikey = Struct.getprop(options, OPTION_APIKEY, NOT_FOUND)

    // True HTTP Basic Auth needs TWO credentials, base64-joined - a single
    // token in the header (the branch below) can never authenticate against
    // an API that actually checks `Authorization: Basic base64(user:pass)`.
    if (java.lang.Boolean.TRUE == Struct.getpath(options, java.util.List.of("auth", "basic"))) {
      val secret = Struct.getprop(options, OPTION_SECRET, NOT_FOUND)
      val noApikey = apikey == null || (apikey match { case s: String => NOT_FOUND == s || "" == s; case _ => false })
      val noSecret = secret == null || (secret match { case s: String => NOT_FOUND == s || "" == s; case _ => false })

      if (noApikey || noSecret) {
        headers.remove(CRED_NAME)
      } else {
        var basicPrefix = ""
        Struct.getpath(options, java.util.List.of("auth", "prefix")) match { case s: String => basicPrefix = s; case _ => }
        val b64 = Base64.getEncoder.encodeToString(
          ((apikey match { case s: String => s; case _ => "" }) + ":" +
            (secret match { case s: String => s; case _ => "" })).getBytes(StandardCharsets.UTF_8))
        if ("" == basicPrefix) headers.put(CRED_NAME, b64)
        else headers.put(CRED_NAME, basicPrefix + " " + b64)
      }

      return spec
    }

    var skip = false
    if (apikey == null) skip = true
    else apikey match {
      case s: String if NOT_FOUND == s || "" == s => skip = true
      case _ =>
    }

    if (skip) {
      headers.remove(CRED_NAME)
    } else {
      var authPrefix = ""
      Struct.getpath(options, java.util.List.of("auth", "prefix")) match { case s: String => authPrefix = s; case _ => }
      val apikeyVal = apikey match { case s: String => s; case _ => "" }
      // A raw credential (empty prefix, e.g. an apiKey scheme) must go in
      // as-is; only a non-empty prefix (Bearer/Basic/OAuth) is space-joined.
      if ("" == authPrefix) headers.put(CRED_NAME, apikeyVal)
      else headers.put(CRED_NAME, authPrefix + " " + apikeyVal)
    }

    spec
  }
}
