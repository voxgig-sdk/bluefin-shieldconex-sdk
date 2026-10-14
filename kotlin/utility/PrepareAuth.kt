package voxgig.bluefinshieldconexsdk.utility

import java.util.Base64

import voxgig.bluefinshieldconexsdk.core.Context
import voxgig.bluefinshieldconexsdk.core.Spec
import voxgig.bluefinshieldconexsdk.utility.struct.Struct

private const val HEADER_AUTH = "authorization"
private const val OPTION_APIKEY = "apikey"
private const val OPTION_SECRET = "secret"
private const val NOT_FOUND = "__NOTFOUND__"

// The client's auth.name option, when set, replaces the name the API declares.
private fun prepareAuthName(options: Any?): String {
  val name = Struct.getpath(options, listOf("auth", "name"))
  return if (name is String && "" != name) name.lowercase() else HEADER_AUTH
}

fun prepareAuth(ctx: Context): Spec {
  val spec = ctx.spec
    ?: throw ctx.makeError("auth_no_spec", "Expected context spec property to be defined.")

  val headers = spec.headers
  val options = ctx.client!!.optionsMap()

  // Public APIs that need no auth omit the options.auth block entirely.
  if (options["auth"] == null) {
    headers.remove(HEADER_AUTH)
    return spec
  }

  val name = prepareAuthName(options)

  // A credential left under the declared name would travel beside the renamed one.
  if (name != HEADER_AUTH) {
    headers.remove(HEADER_AUTH)
  }

  val apikey = Struct.getprop(options, OPTION_APIKEY, NOT_FOUND)

  // True HTTP Basic Auth joins the two credentials, base64-encoded - a single
  // token in the header (the branch below) can never authenticate against
  // an API that actually checks `Authorization: Basic base64(user:pass)`.
  // The password may be empty (RFC 7617): Lob, for one, documents the key as
  // the user with a blank password (`curl -u key:`).
  val basicOpt = Struct.getpath(options, listOf("auth", "basic"))
  if (basicOpt is Boolean && basicOpt) {
    val secret = Struct.getprop(options, OPTION_SECRET, NOT_FOUND)
    val noApikey = apikey == null ||
      (apikey is String && (NOT_FOUND == apikey || "" == apikey))
    val noSecret = secret == null ||
      (secret is String && (NOT_FOUND == secret || "" == secret))

    if (noApikey) {
      headers.remove(name)
    } else {
      var basicPrefix = ""
      val bp = Struct.getpath(options, listOf("auth", "prefix"))
      if (bp is String) {
        basicPrefix = bp
      }
      val b64 = Base64.getEncoder().encodeToString(
        (apikey.toString() + ":" + (if (noSecret) "" else secret.toString())).toByteArray(Charsets.UTF_8))
      // The joined, encoded pair is a wire form neither credential's own
      // registration covers.
      ctx.utility!!.cleanAdd(ctx, b64)
      if ("" == basicPrefix) {
        headers[name] = b64
      } else {
        headers[name] = "$basicPrefix $b64"
      }
    }

    return spec
  }

  var skip = false
  if (apikey == null) {
    skip = true
  } else if (apikey is String && (NOT_FOUND == apikey || "" == apikey)) {
    skip = true
  }

  if (skip) {
    headers.remove(name)
  } else {
    var authPrefix = ""
    val ap = Struct.getpath(options, listOf("auth", "prefix"))
    if (ap is String) {
      authPrefix = ap
    }
    val apikeyVal = if (apikey is String) apikey else ""
    // Empty prefix (raw apiKey credential) must not add a leading space.
    if ("" == authPrefix) {
      headers[name] = apikeyVal
    } else {
      headers[name] = "$authPrefix $apikeyVal"
    }
  }

  return spec
}
