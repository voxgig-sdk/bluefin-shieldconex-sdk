// prepare_auth utility — WHERE THE CREDENTIAL GOES.
//
// GENERATED, not templated: header, query or cookie, and under what name,
// is a fact about THIS API, and tm/ can only hold one answer. Extracted
// from utility/pipeline.hpp, which includes this header and still binds
// `u.prepareAuth = util::prepareAuth` in register_all — the symbol, the
// namespace and every call site are unchanged. See PrepareAuth_cpp.
//
// Do not hand-edit: change the model's security scheme (or
// main.kit.config.auth) and regenerate.

#ifndef SDK_UTILITY_PREPARE_AUTH_HPP
#define SDK_UTILITY_PREPARE_AUTH_HPP

#include <cstddef>
#include <string>

#include "../core/types.hpp"

namespace sdk {
namespace util {


// The cpp core ships no base64 (the vendored encoder under
// feature/secrets/ is compiled only behind that feature's plugin groups and
// is not linked into a plain SDK), so the one placement that needs it
// carries its own.
inline std::string authBase64(const std::string& in) {
  static const char* ALPHABET =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

  std::string out;
  out.reserve(((in.size() + 2) / 3) * 4);
  for (size_t i = 0; i < in.size(); i += 3) {
    unsigned int v = static_cast<unsigned char>(in[i]) << 16;
    if (i + 1 < in.size()) v |= static_cast<unsigned int>(static_cast<unsigned char>(in[i + 1])) << 8;
    if (i + 2 < in.size()) v |= static_cast<unsigned int>(static_cast<unsigned char>(in[i + 2]));
    out += ALPHABET[(v >> 18) & 0x3f];
    out += ALPHABET[(v >> 12) & 0x3f];
    out += (i + 1 < in.size()) ? ALPHABET[(v >> 6) & 0x3f] : '=';
    out += (i + 2 < in.size()) ? ALPHABET[v & 0x3f] : '=';
  }
  return out;
}

inline SpecPtr prepareAuth(CtxPtr ctx) {
  SpecPtr spec = ctx->spec;
  if (!spec) throw ctx->makeError("auth_no_spec", "Expected context spec property to be defined.");

  static const std::string CRED_NAME = "authorization";
  static const std::string NOT_FOUND = "__NOTFOUND__";

  Value headers = spec->headers;
  Value options = ctx->client->optionsMap();

  // Public APIs that need no auth omit the options.auth block entirely, and
  // `auth: null` is the documented way to suppress a credential outright.
  if (is_nullish(getp(options, "auth"))) {
    map_remove(headers, CRED_NAME);
    return spec;
  }

  Value apikey = getp(options, "apikey", Value(NOT_FOUND));

  bool skip = false;
  if (is_nullish(apikey)) {
    skip = true;
  } else if (apikey.is_string() && (apikey.as_string() == NOT_FOUND || apikey.as_string().empty())) {
    skip = true;
  }

  // True HTTP Basic Auth needs TWO credentials, base64-joined - a single
  // token in the header (the branch below) can never authenticate against
  // an API that actually checks `Authorization: Basic base64(user:pass)`.
  if (is_true(Struct::getpath(options, {"auth", "basic"}))) {
    Value secret = getp(options, "secret", Value(NOT_FOUND));

    bool noSecret = false;
    if (is_nullish(secret)) {
      noSecret = true;
    } else if (secret.is_string() && (secret.as_string() == NOT_FOUND || secret.as_string().empty())) {
      noSecret = true;
    }

    if (skip || noSecret) {
      map_remove(headers, CRED_NAME);
    } else {
      std::string authPrefix = as_str(Struct::getpath(options, {"auth", "prefix"}));
      std::string b64 = authBase64(
        (apikey.is_string() ? apikey.as_string() : "") + ":" +
        (secret.is_string() ? secret.as_string() : ""));
      if (authPrefix.empty()) {
        map_put(headers, CRED_NAME, Value(b64));
      } else {
        map_put(headers, CRED_NAME, Value(authPrefix + " " + b64));
      }
    }

    return spec;
  }

  if (skip) {
    map_remove(headers, CRED_NAME);
  } else {
    std::string authPrefix = as_str(Struct::getpath(options, {"auth", "prefix"}));
    std::string apikeyVal = apikey.is_string() ? apikey.as_string() : "";
    // A raw credential (empty prefix, e.g. an apiKey scheme) must go in
    // as-is; only a non-empty prefix (Bearer/Basic/OAuth) is space-joined.
    if (authPrefix.empty()) {
      map_put(headers, CRED_NAME, Value(apikeyVal));
    } else {
      map_put(headers, CRED_NAME, Value(authPrefix + " " + apikeyVal));
    }
  }

  return spec;
}

} // namespace util
} // namespace sdk

#endif // SDK_UTILITY_PREPARE_AUTH_HPP
