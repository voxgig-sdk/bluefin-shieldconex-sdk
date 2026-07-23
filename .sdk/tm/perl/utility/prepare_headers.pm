# BluefinShieldconex SDK utility: prepare_headers

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/../lib/Voxgig/Struct.pm"));
require(Cwd::abs_path("$__dir/../core/helpers.pm"));

package BluefinShieldconexUtilities;

our %REGISTRY;

$REGISTRY{prepare_headers} = sub {
  my ($ctx) = @_;
  my $options = $ctx->{client}->options_map;
  my $headers = BluefinShieldconexHelpers::gp($options, 'headers');
  return {} unless BluefinShieldconexHelpers::rb_truthy($headers);
  my $out = Voxgig::Struct::clone($headers);
  return Voxgig::Struct::ismap($out) ? $out : {};
};

1;
