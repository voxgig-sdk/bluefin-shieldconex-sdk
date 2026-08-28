# BluefinShieldconex SDK feature factory

defmodule BluefinShieldconex.Features do
  def make_feature(name) do
    case name do
      "audit" -> BluefinShieldconex.Feature.Audit.new()
      "clienttrack" -> BluefinShieldconex.Feature.Clienttrack.new()
      "idempotency" -> BluefinShieldconex.Feature.Idempotency.new()
      "log" -> BluefinShieldconex.Feature.Log.new()
      "metrics" -> BluefinShieldconex.Feature.Metrics.new()
      "paging" -> BluefinShieldconex.Feature.Paging.new()
      "ratelimit" -> BluefinShieldconex.Feature.Ratelimit.new()
      "retry" -> BluefinShieldconex.Feature.Retry.new()
      "telemetry" -> BluefinShieldconex.Feature.Telemetry.new()
      "test" -> BluefinShieldconex.Feature.Test.new()
      "timeout" -> BluefinShieldconex.Feature.Timeout.new()
      _ -> BluefinShieldconex.Feature.new()
    end
  end
end
