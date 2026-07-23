#!perl
# Detokenize entity test

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
  my $ent = $testsdk->Detokenize(undef);
  ok(defined $ent, 'detokenize: create instance');
}

BASIC_FLOW: {
  my $setup = detokenize_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op ('create', 'list') {
    my ($_should_skip, $_reason) = BluefinShieldconexTestRunner::is_control_skipped(
      'entityOp', "detokenize." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('detokenize: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
  }
  # The basic flow consumes synthetic IDs from the fixture. In live mode
  # without an *_ENTID env override, those IDs hit the live API and 4xx.
  if ($setup->{synthetic_only}) {
    note('live entity test uses synthetic IDs from fixture - set BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID JSON to run live');
    pass('detokenize: basic flow skipped (synthetic IDs only)');
    last BASIC_FLOW;
  }
  my $client = $setup->{client};
  my %V;

  # CREATE
  $V{detokenize_ref01_ent} = $client->Detokenize(undef);
  $V{detokenize_ref01_data} = BluefinShieldconexHelpers::to_map(BluefinShieldconexHelpers::gp(
    BluefinShieldconexHelpers::gpath($setup->{data}, 'new.detokenize'), 'detokenize_ref01'));

  $V{detokenize_ref01_data_result} = $V{detokenize_ref01_ent}->create($V{detokenize_ref01_data}, undef);
  $V{detokenize_ref01_data} = BluefinShieldconexHelpers::to_map($V{detokenize_ref01_data_result});
  ok(defined $V{detokenize_ref01_data}, 'detokenize create: data');

  # LIST
  $V{detokenize_ref01_match} = {};

  $V{detokenize_ref01_list_result} = $V{detokenize_ref01_ent}->list($V{detokenize_ref01_match}, undef);
  ok(Voxgig::Struct::islist($V{detokenize_ref01_list_result}), 'detokenize list: is array');

  $V{found_item} = Voxgig::Struct::select(
    BluefinShieldconexTestRunner::entity_list_to_data($V{detokenize_ref01_list_result}),
    { 'id' => $V{detokenize_ref01_data}{id} });
  ok(!Voxgig::Struct::isempty($V{found_item}), 'detokenize list: item exists');

}

sub detokenize_basic_setup {
  my ($extra) = @_;
  BluefinShieldconexTestRunner::load_env_local();

  my $entity_data_file = Cwd::abs_path(
    "$FindBin::Bin/../../.sdk/test/entity/detokenize/DetokenizeTestData.json");
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
    ['detokenize01', 'detokenize02', 'detokenize03'],
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
  my $entid_env_raw = $ENV{'BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = BluefinShieldconexTestRunner::env_override({
    'BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID' => $idmap,
    'BLUEFINSHIELDCONEX_TEST_LIVE' => 'FALSE',
    'BLUEFINSHIELDCONEX_TEST_EXPLAIN' => 'FALSE',
    'BLUEFINSHIELDCONEX_APIKEY' => 'NONE',
  });

  my $idmap_resolved = BluefinShieldconexHelpers::to_map($env->{'BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID'});
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
