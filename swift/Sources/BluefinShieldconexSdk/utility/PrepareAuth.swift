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

  let apikey = getprop(.map(options), .string(optionApikey), .string(notFound))

  var skip = isNil(apikey)
  if let apikeyStr = apikey.asString, apikeyStr == notFound || apikeyStr == "" {
    skip = true
  }

  // True HTTP Basic Auth needs TWO credentials, base64-joined - a single
  // token in the header (the branch below) can never authenticate against
  // an API that actually checks `Authorization: Basic base64(user:pass)`.
  if true == gpath(options, "auth", "basic").asBool {
    let secret = getprop(.map(options), .string(optionSecret), .string(notFound))

    var noSecret = isNil(secret)
    if let secretStr = secret.asString, secretStr == notFound || secretStr == "" {
      noSecret = true
    }

    if skip || noSecret {
      headers.entries.removeValue(forKey: headerAuth)
    } else {
      var authPrefix = ""
      if let ap = gpath(options, "auth", "prefix").asString { authPrefix = ap }
      let joined = (apikey.asString ?? "") + ":" + (secret.asString ?? "")
      let b64 = Data(joined.utf8).base64EncodedString()
      // Empty prefix (raw credential) must not add a leading space.
      headers.entries[headerAuth] = .string(authPrefix == "" ? b64 : authPrefix + " " + b64)
    }

    return spec
  }

  if skip {
    headers.entries.removeValue(forKey: headerAuth)
  } else {
    var authPrefix = ""
    if let ap = gpath(options, "auth", "prefix").asString { authPrefix = ap }
    let apikeyVal = apikey.asString ?? ""
    // Empty prefix (raw apiKey credential) must not add a leading space.
    headers.entries[headerAuth] = .string(authPrefix == "" ? apikeyVal : authPrefix + " " + apikeyVal)
  }

  return spec
}
