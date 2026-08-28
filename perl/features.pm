# BluefinShieldconex SDK feature factory

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/feature/base_feature.pm"));
require(Cwd::abs_path("$__dir/feature/audit_feature.pm"));
require(Cwd::abs_path("$__dir/feature/clienttrack_feature.pm"));
require(Cwd::abs_path("$__dir/feature/idempotency_feature.pm"));
require(Cwd::abs_path("$__dir/feature/log_feature.pm"));
require(Cwd::abs_path("$__dir/feature/metrics_feature.pm"));
require(Cwd::abs_path("$__dir/feature/paging_feature.pm"));
require(Cwd::abs_path("$__dir/feature/ratelimit_feature.pm"));
require(Cwd::abs_path("$__dir/feature/retry_feature.pm"));
require(Cwd::abs_path("$__dir/feature/telemetry_feature.pm"));
require(Cwd::abs_path("$__dir/feature/test_feature.pm"));
require(Cwd::abs_path("$__dir/feature/timeout_feature.pm"));

package BluefinShieldconexFeatures;

sub make_feature {
  my ($name) = @_;
  $name = '' unless defined $name;
  return BluefinShieldconexBaseFeature->new if 'base' eq $name;
  return BluefinShieldconexAuditFeature->new if 'audit' eq $name;
  return BluefinShieldconexClienttrackFeature->new if 'clienttrack' eq $name;
  return BluefinShieldconexIdempotencyFeature->new if 'idempotency' eq $name;
  return BluefinShieldconexLogFeature->new if 'log' eq $name;
  return BluefinShieldconexMetricsFeature->new if 'metrics' eq $name;
  return BluefinShieldconexPagingFeature->new if 'paging' eq $name;
  return BluefinShieldconexRatelimitFeature->new if 'ratelimit' eq $name;
  return BluefinShieldconexRetryFeature->new if 'retry' eq $name;
  return BluefinShieldconexTelemetryFeature->new if 'telemetry' eq $name;
  return BluefinShieldconexTestFeature->new if 'test' eq $name;
  return BluefinShieldconexTimeoutFeature->new if 'timeout' eq $name;
  return BluefinShieldconexBaseFeature->new;
}

1;
