# BluefinShieldconex SDK utility: feature_init

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

$REGISTRY{feature_init} = sub {
  my ($ctx, $f) = @_;
  my $fname = $f->get_name;
  my $fopts = {};
  if ($ctx->{options}) {
    my $feature_opts = BluefinShieldconexHelpers::gp($ctx->{options}, 'feature');
    if (Voxgig::Struct::ismap($feature_opts)) {
      my $fo = BluefinShieldconexHelpers::gp($feature_opts, $fname);
      $fopts = $fo if Voxgig::Struct::ismap($fo);
    }
  }
  $f->init($ctx, $fopts) if BluefinShieldconexHelpers::is_true($fopts->{active});
  return;
};

1;
