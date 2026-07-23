#!perl
# Validate entity test

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Cwd ();

use BluefinShieldconexSDK;
require(Cwd::abs_path("$FindBin::Bin/runner.pm"));

{
  my $testsdk = BluefinShieldconexSDK->test(undef, undef);
  my $ent = $testsdk->Validate(undef);
  ok(defined $ent, 'validate: create instance');
}

BASIC_FLOW: {
  my $setup = validate_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op ('create') {
    my ($_should_skip, $_reason) = BluefinShieldconexTestRunner::is_control_skipped(
      'entityOp', "validate." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('validate: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
  }
  # The basic flow consumes synthetic IDs from the fixture. In live mode
  # without an *_ENTID env override, those IDs hit the live API and 4xx.
  if ($setup->{synthetic_only}) {
    note('live entity test uses synthetic IDs from fixture - set BLUEFINSHIELDCONEX_TEST_VALIDATE_ENTID JSON to run live');
    pass('validate: basic flow skipped (synthetic IDs only)');
    last BASIC_FLOW;
  }
  my $client = $setup->{client};
  my %V;

  # CREATE
  $V{validate_ref01_ent} = $client->Validate(undef);
  $V{validate_ref01_data} = BluefinShieldconexHelpers::to_map(BluefinShieldconexHelpers::gp(
    BluefinShieldconexHelpers::gpath($setup->{data}, 'new.validate'), 'validate_ref01'));

  $V{validate_ref01_data_result} = $V{validate_ref01_ent}->create($V{validate_ref01_data}, undef);
  $V{validate_ref01_data} = BluefinShieldconexHelpers::to_map($V{validate_ref01_data_result});
  ok(defined $V{validate_ref01_data}, 'validate create: data');

}

sub validate_basic_setup {
  my ($extra) = @_;
  BluefinShieldconexTestRunner::load_env_local();

  my $entity_data_file = Cwd::abs_path(
    "$FindBin::Bin/../../.sdk/test/entity/validate/ValidateTestData.json");
  my $entity_data = do {
    open my $fh, '<:raw', $entity_data_file or die "Cannot open $entity_data_file: $!";
    local $/;
    Voxgig::Struct::parse_json(<$fh>);
  };

  my $options = {};
  $options->{entity} = $entity_data->{existing};

  my $client = BluefinShieldconexSDK->test($options, $extra);

  # Generate idmap via transform.
  my $idmap = Voxgig::Struct::transform(
    ['validate01', 'validate02', 'validate03'],
    {
      '`$PACK`' => ['', {
        '`$KEY`' => '`$COPY`',
        '`$VAL`' => ['`$FORMAT`', 'upper', '`$COPY`'],
      }],
    }
  );

  # Detect ENTID env override before env_override consumes it. When live
  # mode is on without a real override, the basic test runs against
  # synthetic IDs from the fixture and 4xx's. Surface this so the test can
  # skip.
  my $entid_env_raw = $ENV{'BLUEFINSHIELDCONEX_TEST_VALIDATE_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = BluefinShieldconexTestRunner::env_override({
    'BLUEFINSHIELDCONEX_TEST_VALIDATE_ENTID' => $idmap,
    'BLUEFINSHIELDCONEX_TEST_LIVE' => 'FALSE',
    'BLUEFINSHIELDCONEX_TEST_EXPLAIN' => 'FALSE',
    'BLUEFINSHIELDCONEX_APIKEY' => 'NONE',
  });

  my $idmap_resolved = BluefinShieldconexHelpers::to_map($env->{'BLUEFINSHIELDCONEX_TEST_VALIDATE_ENTID'});
  if (!defined $idmap_resolved) {
    $idmap_resolved = BluefinShieldconexHelpers::to_map($idmap);
  }

  if ((($env->{'BLUEFINSHIELDCONEX_TEST_LIVE'}) || '') eq 'TRUE') {
    my $merged_opts = Voxgig::Struct::merge([
      {
        'apikey' => $env->{'BLUEFINSHIELDCONEX_APIKEY'},
      },
      (Voxgig::Struct::ismap($extra) ? $extra : {}),
    ]);
    $client = BluefinShieldconexSDK->new(BluefinShieldconexHelpers::to_map($merged_opts));
  }

  my $live = ((($env->{'BLUEFINSHIELDCONEX_TEST_LIVE'}) || '') eq 'TRUE') ? 1 : 0;
  return {
    'client' => $client,
    'data' => $entity_data,
    'idmap' => $idmap_resolved,
    'env' => $env,
    'explain' => ((($env->{'BLUEFINSHIELDCONEX_TEST_EXPLAIN'}) || '') eq 'TRUE') ? 1 : 0,
    'live' => $live,
    'synthetic_only' => ($live && !$idmap_overridden) ? 1 : 0,
    'now' => BluefinShieldconexHelpers::now_ms(),
  };
}

done_testing();
