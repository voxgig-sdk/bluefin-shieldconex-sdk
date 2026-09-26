# BluefinShieldconex SDK utility: prepare_auth
#
# WHERE THE CREDENTIAL GOES IS A FACT ABOUT THE API, so this module is
# GENERATED from the model rather than copied from tm/. Do not edit by hand.
#
# Extracted from BluefinShieldconex.Utility, which still owns the registration
# (`{"prepare_auth", &PrepareAuth.prepare_auth_impl/1}`) and the
# `prepare_auth/1` dispatch wrapper every caller goes through. A feature that
# overrides the utility slot overrides this, exactly as before.

defmodule BluefinShieldconex.PrepareAuth do
  alias Voxgig.Struct, as: S
  alias BluefinShieldconex.Context

  @cred_name "authorization"
  @option_apikey "apikey"
  @option_secret "secret"
  @not_found "__NOTFOUND__"

  def prepare_auth_impl(ctx) do
    spec = S.getprop(ctx, "spec")

    if spec == nil do
      {nil, Context.make_error(ctx, "auth_no_spec", "Expected context spec property to be defined.")}
    else
      headers = S.getprop(spec, "headers")
      options = opts_map(S.getprop(ctx, "client"))

      # Public APIs that need no auth omit the options.auth block entirely.
      if S.getprop(options, "auth") == nil do
        S.delprop(headers, @cred_name)
        {spec, nil}
      else
        apikey = S.getprop(options, @option_apikey, @not_found)

        # True HTTP Basic Auth needs TWO credentials, base64-joined - a single
        # token in the header (the branch below) can never authenticate
        # against an API that actually checks
        # `Authorization: Basic base64(user:pass)`.
        if S.getpath(options, "auth.basic") == true do
          secret = S.getprop(options, @option_secret, @not_found)
          no_apikey = not is_binary(apikey) or apikey == @not_found or apikey == ""
          no_secret = not is_binary(secret) or secret == @not_found or secret == ""

          if no_apikey or no_secret do
            S.delprop(headers, @cred_name)
          else
            ap = S.getpath(options, "auth.prefix")
            auth_prefix = if is_binary(ap), do: ap, else: ""
            b64 = Base.encode64(apikey <> ":" <> secret)
            hv = if auth_prefix != "", do: auth_prefix <> " " <> b64, else: b64
            S.setprop(headers, @cred_name, hv)
          end
        else
          if (is_binary(apikey) and apikey == @not_found) or apikey == nil or apikey == "" do
            S.delprop(headers, @cred_name)
          else
            ap = S.getpath(options, "auth.prefix")
            auth_prefix = if is_binary(ap), do: ap, else: ""
            apikey_val = if is_binary(apikey), do: apikey, else: ""
            # Empty prefix (raw apiKey credential) must not add a leading space.
            hv = if auth_prefix != "", do: auth_prefix <> " " <> apikey_val, else: apikey_val
            S.setprop(headers, @cred_name, hv)
          end
        end

        {spec, nil}
      end
    end
  end

  # The client's options as a MAP, cloned. The clone is load-bearing: the
  # secrets feature rewrites options.apikey on the live client, and
  # prepare_auth must read a snapshot rather than the node the feature is
  # mutating. Same body as BluefinShieldconex.Utility's own private opts_map/1.
  defp opts_map(client) do
    o = S.clone(S.getprop(client, "options"))
    if S.ismap(o), do: o, else: S.jm([])
  end
end
