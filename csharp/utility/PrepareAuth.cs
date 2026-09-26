// BluefinShieldconex SDK utility: prepareAuth - shape the authorization header
// from the client options.

using Voxgig.Struct;

namespace BluefinShieldconexSdk.Util;

public static partial class SdkUtility
{
    private const string HeaderAuth = "authorization";
    private const string OptionApikey = "apikey";
    private const string OptionSecret = "secret";
    private const string NotFound = "__NOTFOUND__";

    internal static Spec PrepareAuthUtil(Context ctx)
    {
        var spec = ctx.Spec ?? throw ctx.MakeError("auth_no_spec",
            "Expected context spec property to be defined.");

        var headers = spec.Headers;
        var options = ctx.Client!.OptionsMap();

        // Public APIs that need no auth omit the options.auth block entirely.
        if (!options.TryGetValue("auth", out var auth) || auth == null)
        {
            headers.Remove(HeaderAuth);
            return spec;
        }

        var apikey = StructUtils.GetProp(options, OptionApikey, NotFound);

        // True HTTP Basic Auth needs TWO credentials, base64-joined - a
        // single token in the header (the branch below) can never
        // authenticate against an API that actually checks
        // `Authorization: Basic base64(user:pass)`.
        if (StructUtils.GetPath(options, StructUtils.Jt("auth", "basic")) is bool isBasic &&
            isBasic)
        {
            var secret = StructUtils.GetProp(options, OptionSecret, NotFound);

            var noApikey = apikey == null ||
                (apikey is string akStr && (akStr == NotFound || akStr == ""));
            var noSecret = secret == null ||
                (secret is string skStr && (skStr == NotFound || skStr == ""));

            if (noApikey || noSecret)
            {
                headers.Remove(HeaderAuth);
            }
            else
            {
                var basicPrefix = "";
                if (StructUtils.GetPath(options, StructUtils.Jt("auth", "prefix")) is string bp)
                {
                    basicPrefix = bp;
                }
                var b64 = Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(
                    (apikey as string ?? "") + ":" + (secret as string ?? "")));
                headers[HeaderAuth] = basicPrefix == ""
                    ? b64
                    : basicPrefix + " " + b64;
            }

            return spec;
        }

        var skip = apikey == null ||
            (apikey is string apikeyStr && (apikeyStr == NotFound || apikeyStr == ""));

        if (skip)
        {
            headers.Remove(HeaderAuth);
        }
        else
        {
            var authPrefix = "";
            if (StructUtils.GetPath(options, StructUtils.Jt("auth", "prefix")) is string ap)
            {
                authPrefix = ap;
            }
            var apikeyVal = apikey as string ?? "";
            // Empty prefix (raw apiKey credential) must not add a leading space.
            headers[HeaderAuth] = authPrefix == ""
                ? apikeyVal
                : authPrefix + " " + apikeyVal;
        }

        return spec;
    }
}
