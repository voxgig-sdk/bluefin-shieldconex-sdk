// BluefinShieldconex SDK utility: prepareAuth - place the API credential.
//
// GENERATED, not templated: WHERE the credential goes - header, query or
// cookie, and under what name - is a fact about THIS API, and tm/ can only
// hold one answer. Extracted from utility/Prepare.swift, which keeps the
// seven prepare* functions that do not depend on the model. Bound by
// utility/Register.swift (`u.prepareAuth = prepareAuthUtil`) exactly as
// before: same module, same internal symbol, no import needed.
//
// See cmp/swift/PrepareAuth_swift.ts.

import Foundation

private let headerAuth = "authorization"
private let optionApikey = "apikey"
private let optionSecret = "secret"
private let notFound = "__NOTFOUND__"

// The client's auth.name option, when set, replaces the name the API declares.
private func prepareAuthName(_ options: VMap) -> String {
  if let name = gpath(options, "auth", "name").asString, name != "" {
    return name.lowercased()
  }
  return headerAuth
}

func prepareAuthUtil(_ ctx: Context) throws -> Spec {
  guard let spec = ctx.spec else {
    throw ctx.makeError("auth_no_spec", "Expected context spec property to be defined.")
  }

  let headers = spec.headers
  let options = ctx.client!.optionsMap()

  // Public APIs that need no auth omit the options.auth block entirely.
  let auth = getprop(.map(options), .string("auth"))
  if isNil(auth) {
    headers.entries.removeValue(forKey: headerAuth)
    return spec
  }

  let name = prepareAuthName(options)

  // A credential left under the declared name would travel beside the renamed one.
  if name != headerAuth {
    headers.entries.removeValue(forKey: headerAuth)
  }

  let apikey = getprop(.map(options), .string(optionApikey), .string(notFound))

  var skip = isNil(apikey)
  if let apikeyStr = apikey.asString, apikeyStr == notFound || apikeyStr == "" {
    skip = true
  }

  // True HTTP Basic Auth joins the two credentials, base64-encoded - a single
  // token in the header (the branch below) can never authenticate against
  // an API that actually checks `Authorization: Basic base64(user:pass)`.
  // The password may be empty (RFC 7617): Lob, for one, documents the key as
  // the user with a blank password (`curl -u key:`).
  if true == gpath(options, "auth", "basic").asBool {
    let secret = getprop(.map(options), .string(optionSecret), .string(notFound))

    var noSecret = isNil(secret)
    if let secretStr = secret.asString, secretStr == notFound || secretStr == "" {
      noSecret = true
    }

    if skip {
      headers.entries.removeValue(forKey: name)
    } else {
      var authPrefix = ""
      if let ap = gpath(options, "auth", "prefix").asString { authPrefix = ap }
      let joined = (apikey.asString ?? "") + ":" + (noSecret ? "" : (secret.asString ?? ""))
      let b64 = Data(joined.utf8).base64EncodedString()
      // The joined, encoded pair is a wire form neither credential's own
      // registration covers.
      ctx.utility!.cleanAdd(ctx, .string(b64))
      // Empty prefix (raw credential) must not add a leading space.
      headers.entries[name] = .string(authPrefix == "" ? b64 : authPrefix + " " + b64)
    }

    return spec
  }

  if skip {
    headers.entries.removeValue(forKey: name)
  } else {
    var authPrefix = ""
    if let ap = gpath(options, "auth", "prefix").asString { authPrefix = ap }
    let apikeyVal = apikey.asString ?? ""
    // Empty prefix (raw apiKey credential) must not add a leading space.
    headers.entries[name] = .string(authPrefix == "" ? apikeyVal : authPrefix + " " + apikeyVal)
  }

  return spec
}
