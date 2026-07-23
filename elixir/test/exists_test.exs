defmodule BluefinShieldconex.ExistsTest do
  use ExUnit.Case

  test "should create test sdk" do
    testsdk = BluefinShieldconex.test()
    assert testsdk != nil
  end
end
