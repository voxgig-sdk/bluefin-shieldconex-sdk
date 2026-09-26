package voxgig.bluefinshieldconexsdk.utility;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import voxgig.bluefinshieldconexsdk.core.Context;
import voxgig.bluefinshieldconexsdk.core.Spec;
import voxgig.bluefinshieldconexsdk.utility.struct.Struct;

final class PrepareAuth {

  private PrepareAuth() {}

  static final String CRED_NAME = "authorization";
  static final String OPTION_APIKEY = "apikey";
  static final String OPTION_SECRET = "secret";
  static final String NOT_FOUND = "__NOTFOUND__";

  static Spec prepareAuth(Context ctx) {
    Spec spec = ctx.spec;
    if (spec == null) {
      throw ctx.makeError("auth_no_spec",
          "Expected context spec property to be defined.");
    }

    Map<String, Object> headers = spec.headers;
    Map<String, Object> options = ctx.client.optionsMap();

    // Public APIs that need no auth omit the options.auth block entirely.
    if (options.get("auth") == null) {
      headers.remove(CRED_NAME);
      return spec;
    }

    Object apikey = Struct.getprop(options, OPTION_APIKEY, NOT_FOUND);

    // True HTTP Basic Auth needs TWO credentials, base64-joined - a single
    // token in the header (the branch below) can never authenticate against
    // an API that actually checks `Authorization: Basic base64(user:pass)`.
    if (Boolean.TRUE.equals(Struct.getpath(options, List.of("auth", "basic")))) {
      Object secret = Struct.getprop(options, OPTION_SECRET, NOT_FOUND);
      boolean noApikey = !(apikey instanceof String)
          || NOT_FOUND.equals(apikey) || "".equals(apikey);
      boolean noSecret = !(secret instanceof String)
          || NOT_FOUND.equals(secret) || "".equals(secret);

      if (noApikey || noSecret) {
        headers.remove(CRED_NAME);
      }
      else {
        String basicPrefix = "";
        Object bp = Struct.getpath(options, List.of("auth", "prefix"));
        if (bp instanceof String) {
          basicPrefix = (String) bp;
        }
        String b64 = Base64.getEncoder().encodeToString(
            ((String) apikey + ":" + (String) secret).getBytes(StandardCharsets.UTF_8));
        if ("".equals(basicPrefix)) {
          headers.put(CRED_NAME, b64);
        }
        else {
          headers.put(CRED_NAME, basicPrefix + " " + b64);
        }
      }

      return spec;
    }

    boolean skip = false;
    if (apikey == null) {
      skip = true;
    }
    else if (apikey instanceof String
        && (NOT_FOUND.equals(apikey) || "".equals(apikey))) {
      skip = true;
    }

    if (skip) {
      headers.remove(CRED_NAME);
    }
    else {
      String authPrefix = "";
      Object ap = Struct.getpath(options, List.of("auth", "prefix"));
      if (ap instanceof String) {
        authPrefix = (String) ap;
      }
      String apikeyVal = apikey instanceof String ? (String) apikey : "";
      // Empty prefix (raw apiKey credential) must not add a leading space.
      if ("".equals(authPrefix)) {
        headers.put(CRED_NAME, apikeyVal);
      }
      else {
        headers.put(CRED_NAME, authPrefix + " " + apikeyVal);
      }
    }

    return spec;
  }
}
