# BluefinShieldconex SDK feature factory

defmodule BluefinShieldconex.Features do
  def make_feature(name) do
    case name do
      "test" -> BluefinShieldconex.Feature.Test.new()
      _ -> BluefinShieldconex.Feature.new()
    end
  end
end
