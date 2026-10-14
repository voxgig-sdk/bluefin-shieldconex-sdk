# BluefinShieldconex SDK utility: prepare_body

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/media.pm"));

package BluefinShieldconexUtilities;

our %REGISTRY;

$REGISTRY{prepare_body} = sub {
  my ($ctx) = @_;
  return undef unless 'data' eq $ctx->{op}{input};
  return BluefinShieldconexUtilities::raw_body($ctx->{reqdata})
    if BluefinShieldconexUtilities::is_raw_request($ctx->{point});
  return $ctx->{utility}{transform_request}->($ctx);
};

1;
