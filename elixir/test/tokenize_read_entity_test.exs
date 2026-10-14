# TokenizeRead entity test (offline, mock transport)

defmodule BluefinShieldconex.TokenizeReadEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S

  test "should create instance" do
    sdk = BluefinShieldconex.test()
    ent = BluefinShieldconex.tokenize_read(sdk)
    assert ent != nil
  end

  test "should create then read back" do
    sdk = BluefinShieldconex.test(S.jm(["entity", S.jm(["tokenize_read", S.jm([])])]))
    ent = BluefinShieldconex.tokenize_read(sdk)
    created = BluefinShieldconex.Entity.TokenizeRead.create(ent, S.jm(["name", "test-create"]))
    made = BluefinShieldconex.EntityBase.data_get(created)
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end

  test "should refuse an invalid request" do
    if BluefinShieldconex.FeatureHarness.has_feature("validate") do
      client = BluefinShieldconex.test(nil, S.jm(["feature", S.jm(["validate", S.jm(["active", true])])]))

      err =
        assert_raise BluefinShieldconex.Error, fn ->
          BluefinShieldconex.Entity.TokenizeRead.create(BluefinShieldconex.tokenize_read(client), S.jm(["bfid", 1]))
        end

      assert err.code == "validate_failed"
    end
  end
end
