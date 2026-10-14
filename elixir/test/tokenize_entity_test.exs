# Tokenize entity test (offline, mock transport)

defmodule BluefinShieldconex.TokenizeEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias BluefinShieldconex.Helpers, as: H
  alias BluefinShieldconex.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/tokenize/TokenizeTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    BluefinShieldconex.test(S.jm(["entity", existing]))
  end

  test "should create instance" do
    sdk = BluefinShieldconex.test()
    ent = BluefinShieldconex.tokenize(sdk)
    assert ent != nil
  end

  test "should list records" do
    sdk = mk_sdk()
    ent = BluefinShieldconex.tokenize(sdk)
    # The op resolves to one ENTITY per record; the record is reached with
    # data_get. See AGENTS.md "Entity operations return ENTITIES".
    result = BluefinShieldconex.Entity.Tokenize.list(ent, S.jm([]))
    assert S.islist(result)
    if S.size(result) > 0 do
      Enum.each(0..(S.size(result) - 1), fn i ->
        assert S.ismap(BluefinShieldconex.EntityBase.data_get(S.getelem(result, i)))
      end)
    end
  end

  test "should create then read back" do
    sdk = BluefinShieldconex.test(S.jm(["entity", S.jm(["tokenize", S.jm([])])]))
    ent = BluefinShieldconex.tokenize(sdk)
    created = BluefinShieldconex.Entity.Tokenize.create(ent, S.jm(["name", "test-create"]))
    made = BluefinShieldconex.EntityBase.data_get(created)
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end

  test "should report a failed stream" do
    offline = S.jm(["net", S.jm(["offline", true])])

    err =
      assert_raise BluefinShieldconex.Error, fn ->
        Enum.to_list(BluefinShieldconex.EntityBase.stream(BluefinShieldconex.tokenize(BluefinShieldconex.test(offline)), "list"))
      end

    assert String.contains?(Exception.message(err), "offline")

    quiet = S.jm(["ctrl", S.jm(["throw", false])])
    Enum.to_list(BluefinShieldconex.EntityBase.stream(BluefinShieldconex.tokenize(BluefinShieldconex.test(offline)), "list", nil, quiet))

    if BluefinShieldconex.FeatureHarness.has_feature("rbac") do
      denied = BluefinShieldconex.test(nil, S.jm(["feature", S.jm(["rbac", S.jm(["active", true, "deny", true])])]))

      err =
        assert_raise BluefinShieldconex.Error, fn ->
          Enum.to_list(BluefinShieldconex.EntityBase.stream(BluefinShieldconex.tokenize(denied), "list"))
        end

      assert err.code == "rbac_denied"
    end
  end

  test "should leave the caller's ctrl" do
    explain = S.jm([])
    ctrl = S.jm(["explain", explain])
    Enum.to_list(BluefinShieldconex.EntityBase.stream(BluefinShieldconex.tokenize(BluefinShieldconex.test()), "list", nil, S.jm(["ctrl", ctrl])))
    assert S.keysof(ctrl) == ["explain"]
    assert S.size(explain) > 0
  end

  test "should end a stream whose source fails as the operation would" do
    seen = S.jm(["n", 0])

    hook =
      S.jm([
        "name", "lazyhook", "version", "0.0.1", "active", true, "options", S.jm([]),
        "init", fn _ctx, _opts -> nil end,
        "PreDone", fn ctx ->
          S.setprop(S.getprop(ctx, "result"), "stream",
            fn -> Stream.map([1], fn _ -> raise "tokenize source failed" end) end)
        end,
        "PreUnexpected", fn _ctx -> S.setprop(seen, "n", S.getprop(seen, "n") + 1) end
      ])

    client = BluefinShieldconex.new(S.jm(["feature", S.jm(["test", S.jm(["active", true])]), "extend", S.jt([hook])]))

    err =
      try do
        Enum.to_list(BluefinShieldconex.EntityBase.stream(BluefinShieldconex.tokenize(client), "list"))
        nil
      rescue
        e -> e
      end

    assert err != nil and String.contains?(Exception.message(err), "source failed")
    assert S.getprop(seen, "n") > 0

    fired = S.getprop(seen, "n")
    quiet = S.jm(["ctrl", S.jm(["throw", false])])
    assert Enum.to_list(BluefinShieldconex.EntityBase.stream(BluefinShieldconex.tokenize(client), "list", nil, quiet)) == []
    assert S.getprop(seen, "n") > fired
  end

  test "should fire PreUnexpected" do
    seen = S.jm(["n", 0])

    hook =
      S.jm([
        "name", "failhook", "version", "0.0.1", "active", true, "options", S.jm([]),
        "init", fn _ctx, _opts -> nil end,
        "PreSpec", fn _ctx -> raise "tokenize hook failed" end,
        "PreUnexpected", fn _ctx -> S.setprop(seen, "n", S.getprop(seen, "n") + 1) end
      ])

    client = BluefinShieldconex.new(S.jm(["feature", S.jm(["test", S.jm(["active", true])]), "extend", S.jt([hook])]))

    err =
      try do
        BluefinShieldconex.Entity.Tokenize.list(BluefinShieldconex.tokenize(client), S.jm([]))
        nil
      rescue
        e -> e
      end

    assert err != nil and String.contains?(Exception.message(err), "hook failed")
    assert S.getprop(seen, "n") > 0

    fired = S.getprop(seen, "n")
    assert BluefinShieldconex.Entity.Tokenize.list(BluefinShieldconex.tokenize(client), S.jm([]), S.jm(["throw", false])) == nil
    assert S.getprop(seen, "n") > fired
  end

  test "should refuse an invalid request" do
    if BluefinShieldconex.FeatureHarness.has_feature("validate") do
      client = BluefinShieldconex.test(nil, S.jm(["feature", S.jm(["validate", S.jm(["active", true])])]))

      err =
        assert_raise BluefinShieldconex.Error, fn ->
          BluefinShieldconex.Entity.Tokenize.list(BluefinShieldconex.tokenize(client), S.jm(["field_name", 1, "template_ref", "x"]))
        end

      assert err.code == "validate_failed"
    end
  end
end
