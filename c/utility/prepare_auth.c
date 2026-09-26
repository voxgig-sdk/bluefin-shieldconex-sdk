// prepare_auth utility (mirrors utility/prepare_auth.rs).
//
// GENERATED, not templated: where the credential goes - header, query or
// cookie, and under what name - is a fact about THIS API, and tm/ can only
// hold one answer. See PrepareAuth_c.

#include "sdk.h"

#include <stdio.h>
#include <string.h>

#define CRED_NAME "authorization"
#define OPTION_APIKEY "apikey"
#define OPTION_SECRET "secret"
#define NOT_FOUND "__NOTFOUND__"

// The c core ships no base64 (the vendored encoder under
// feature/secrets/plugins/ is gated behind that feature and is not linked
// into a plain SDK), so the one placement that needs it carries its own.
static const char B64_ALPHABET[] =
  "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

static void b64_encode(const char* in, char* out, size_t outcap) {
  size_t n = strlen(in);
  size_t o = 0;
  for (size_t i = 0; i < n; i += 3) {
    unsigned int v = (unsigned char)in[i] << 16;
    if (i + 1 < n) v |= (unsigned int)(unsigned char)in[i + 1] << 8;
    if (i + 2 < n) v |= (unsigned int)(unsigned char)in[i + 2];
    if (o + 5 > outcap) break;
    out[o++] = B64_ALPHABET[(v >> 18) & 0x3f];
    out[o++] = B64_ALPHABET[(v >> 12) & 0x3f];
    out[o++] = (i + 1 < n) ? B64_ALPHABET[(v >> 6) & 0x3f] : '=';
    out[o++] = (i + 2 < n) ? B64_ALPHABET[v & 0x3f] : '=';
  }
  out[o] = '\0';
}

Spec* prepare_auth_util(Context* ctx, PNError** err) {
  *err = NULL;
  Spec* spec = ctx->spec;
  if (!spec) {
    *err = context_make_error(ctx, "auth_no_spec", "Expected context spec property to be defined.");
    return NULL;
  }

  voxgig_value* headers = spec->headers;
  voxgig_value* options = ctx->client ? sdk_options_map(ctx->client) : ctx->options;

  voxgig_value* auth = getp(options, "auth");
  if (v_is_noval(auth) || v_is_null(auth)) {
    voxgig_value* k = voxgig_new_string(CRED_NAME);
    voxgig_delprop(headers, k);
    voxgig_release(k);
    return spec;
  }

  voxgig_value* akey_key = voxgig_new_string(OPTION_APIKEY);
  voxgig_value* nf = voxgig_new_string(NOT_FOUND);
  voxgig_value* apikey = voxgig_getprop(options, akey_key, nf);
  voxgig_release(akey_key);
  voxgig_release(nf);

  bool skip;
  if (v_is_noval(apikey) || v_is_null(apikey)) {
    skip = true;
  } else if (voxgig_is_string(apikey)) {
    const char* s = voxgig_as_string(apikey);
    skip = (strcmp(s, NOT_FOUND) == 0 || s[0] == '\0');
  } else {
    skip = false;
  }

  // True HTTP Basic Auth needs TWO credentials, base64-joined - a single
  // token in the header (the branch below) can never authenticate against
  // an API that actually checks `Authorization: Basic base64(user:pass)`.
  bool want_basic = false;
  get_bool(auth, "basic", &want_basic);
  if (want_basic) {
    voxgig_value* sec_key = voxgig_new_string(OPTION_SECRET);
    voxgig_value* snf = voxgig_new_string(NOT_FOUND);
    voxgig_value* secret = voxgig_getprop(options, sec_key, snf);
    voxgig_release(sec_key);
    voxgig_release(snf);

    bool no_secret;
    if (v_is_noval(secret) || v_is_null(secret)) {
      no_secret = true;
    } else if (voxgig_is_string(secret)) {
      const char* s = voxgig_as_string(secret);
      no_secret = (strcmp(s, NOT_FOUND) == 0 || s[0] == '\0');
    } else {
      no_secret = false;
    }

    if (skip || no_secret) {
      voxgig_value* k = voxgig_new_string(CRED_NAME);
      voxgig_delprop(headers, k);
      voxgig_release(k);
    } else {
      voxgig_value* prefix_v = getpath2(options, "auth", "prefix");
      const char* auth_prefix = voxgig_is_string(prefix_v) ? voxgig_as_string(prefix_v) : "";
      char pair[1024];
      char b64[1400];
      snprintf(pair, sizeof(pair), "%s:%s",
               voxgig_is_string(apikey) ? voxgig_as_string(apikey) : "",
               voxgig_is_string(secret) ? voxgig_as_string(secret) : "");
      b64_encode(pair, b64, sizeof(b64));
      if (auth_prefix[0] == '\0') {
        setp(headers, CRED_NAME, v_str(b64));
      } else {
        char buf[1536];
        snprintf(buf, sizeof(buf), "%s %s", auth_prefix, b64);
        setp(headers, CRED_NAME, v_str(buf));
      }
    }

    return spec;
  }

  if (skip) {
    voxgig_value* k = voxgig_new_string(CRED_NAME);
    voxgig_delprop(headers, k);
    voxgig_release(k);
  } else {
    voxgig_value* prefix_v = getpath2(options, "auth", "prefix");
    const char* auth_prefix = voxgig_is_string(prefix_v) ? voxgig_as_string(prefix_v) : "";
    const char* apikey_val = voxgig_is_string(apikey) ? voxgig_as_string(apikey) : "";
    // A raw credential (empty prefix, e.g. an apiKey scheme) must go in
    // as-is; only a non-empty prefix (Bearer/Basic/OAuth) is space-joined.
    if (auth_prefix[0] == '\0') {
      setp(headers, CRED_NAME, v_str(apikey_val));
    } else {
      char buf[1024];
      snprintf(buf, sizeof(buf), "%s %s", auth_prefix, apikey_val);
      setp(headers, CRED_NAME, v_str(buf));
    }
  }

  return spec;
}
