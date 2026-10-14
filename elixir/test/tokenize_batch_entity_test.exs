# TokenizeBatch entity test (offline, mock transport)

defmodule BluefinShieldconex.TokenizeBatchEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S

  test "should create instance" do
    sdk = BluefinShieldconex.test()
    ent = BluefinShieldconex.tokenize_batch(sdk)
    assert ent != nil
  end

  test "should create then read back" do
    sdk = BluefinShieldconex.test(S.jm(["entity", S.jm(["tokenize_batch", S.jm([])])]))
    ent = BluefinShieldconex.tokenize_batch(sdk)
    created = BluefinShieldconex.Entity.TokenizeBatch.create(ent, S.jm(["name", "test-create"]))
    made = BluefinShieldconex.EntityBase.data_get(created)
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end

  test "should refuse an invalid request" do
    if BluefinShieldconex.FeatureHarness.has_feature("validate") do
      client = BluefinShieldconex.test(nil, S.jm(["feature", S.jm(["validate", S.jm(["active", true])])]))

      err =
        assert_raise BluefinShieldconex.Error, fn ->
          BluefinShieldconex.Entity.TokenizeBatch.create(BluefinShieldconex.tokenize_batch(client), S.jm(["messageId", 1]))
        end

      assert err.code == "validate_failed"
    end
  end
end
