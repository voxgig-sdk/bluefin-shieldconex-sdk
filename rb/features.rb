# BluefinShieldconex SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/audit_feature'
require_relative 'feature/clienttrack_feature'
require_relative 'feature/idempotency_feature'
require_relative 'feature/log_feature'
require_relative 'feature/metrics_feature'
require_relative 'feature/paging_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/telemetry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module BluefinShieldconexFeatures
  def self.make_feature(name)
    case name
    when "base"
      BluefinShieldconexBaseFeature.new
    when "audit"
      BluefinShieldconexAuditFeature.new
    when "clienttrack"
      BluefinShieldconexClienttrackFeature.new
    when "idempotency"
      BluefinShieldconexIdempotencyFeature.new
    when "log"
      BluefinShieldconexLogFeature.new
    when "metrics"
      BluefinShieldconexMetricsFeature.new
    when "paging"
      BluefinShieldconexPagingFeature.new
    when "ratelimit"
      BluefinShieldconexRatelimitFeature.new
    when "retry"
      BluefinShieldconexRetryFeature.new
    when "telemetry"
      BluefinShieldconexTelemetryFeature.new
    when "test"
      BluefinShieldconexTestFeature.new
    when "timeout"
      BluefinShieldconexTimeoutFeature.new
    else
      BluefinShieldconexBaseFeature.new
    end
  end
end
