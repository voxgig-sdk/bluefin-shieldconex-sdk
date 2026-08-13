# Detokenize entity test (offline, mock transport)

defmodule BluefinShieldconex.DetokenizeEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias BluefinShieldconex.Helpers, as: H
  alias BluefinShieldconex.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/detokenize/DetokenizeTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    BluefinShieldconex.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.detokenize"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

  test "should create instance" do
    sdk = BluefinShieldconex.test()
    ent = BluefinShieldconex.detokenize(sdk)
    assert ent != nil
  end

  test "should list records" do
    sdk = mk_sdk()
    ent = BluefinShieldconex.detokenize(sdk)
    # The op resolves to one ENTITY per record; the record is reached with
    # data_get. See AGENTS.md "Entity operations return ENTITIES".
    result = BluefinShieldconex.Entity.Detokenize.list(ent, S.jm([]))
    assert S.islist(result)
    if S.size(result) > 0 do
      Enum.each(0..(S.size(result) - 1), fn i ->
        assert S.ismap(BluefinShieldconex.EntityBase.data_get(S.getelem(result, i)))
      end)
    end
  end

  test "should create then read back" do
    sdk = BluefinShieldconex.test(S.jm(["entity", S.jm(["detokenize", S.jm([])])]))
    ent = BluefinShieldconex.detokenize(sdk)
    created = BluefinShieldconex.Entity.Detokenize.create(ent, S.jm(["name", "test-create"]))
    made = BluefinShieldconex.EntityBase.data_get(created)
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end
end
