# Validate entity test (offline, mock transport)

defmodule BluefinShieldconex.ValidateEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias BluefinShieldconex.Helpers, as: H
  alias BluefinShieldconex.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/validate/ValidateTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    BluefinShieldconex.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.validate"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

  test "should create instance" do
    sdk = BluefinShieldconex.test()
    ent = BluefinShieldconex.validate(sdk)
    assert ent != nil
  end

  test "should create then read back" do
    sdk = BluefinShieldconex.test(S.jm(["entity", S.jm(["validate", S.jm([])])]))
    ent = BluefinShieldconex.validate(sdk)
    made = BluefinShieldconex.Entity.Validate.create(ent, S.jm(["name", "test-create"]))
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end
end
