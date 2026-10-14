# Validate entity test (offline, mock transport)

defmodule BluefinShieldconex.ValidateEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S

  test "should create instance" do
    sdk = BluefinShieldconex.test()
    ent = BluefinShieldconex.validate(sdk)
    assert ent != nil
  end

  test "should create then read back" do
    sdk = BluefinShieldconex.test(S.jm(["entity", S.jm(["validate", S.jm([])])]))
    ent = BluefinShieldconex.validate(sdk)
    created = BluefinShieldconex.Entity.Validate.create(ent, S.jm(["name", "test-create"]))
    made = BluefinShieldconex.EntityBase.data_get(created)
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end

  test "should refuse an invalid request" do
    if BluefinShieldconex.FeatureHarness.has_feature("validate") do
      client = BluefinShieldconex.test(nil, S.jm(["feature", S.jm(["validate", S.jm(["active", true])])]))

      err =
        assert_raise BluefinShieldconex.Error, fn ->
          BluefinShieldconex.Entity.Validate.create(BluefinShieldconex.validate(client), S.jm(["messageId", 1, "templateRef", "x"]))
        end

      assert err.code == "validate_failed"
    end
  end
end
