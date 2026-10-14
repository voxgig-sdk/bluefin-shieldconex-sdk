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

# main.kit.test.live.strict is true (the default is true): a live
# request that fails, or a live test missing an input it needs,
# fails the test.
# An account with no record for a test to read skips it either way.
use constant LIVE_STRICT => 1;

{
  my $testsdk = BluefinShieldconexSDK->test(undef, undef);
  my $ent = $testsdk->Validate(undef);
  ok(defined $ent, 'validate: create instance');
}

SKIP: {
  skip('feature not present in this SDK: validate', 1)
    unless BluefinShieldconexConfig::shared_config()->{feature}{validate};
  my $client = BluefinShieldconexSDK->test(undef, { feature => { validate => { active => 1 } } });
  my $err = eval { $client->Validate(undef)->create({ 'messageId' => 1, 'templateRef' => 'x' }, undef); undef } // $@;
  is(ref $err ? $err->{code} : undef, 'validate_failed',
    'validate: an invalid request fails with validate_failed');
}

BASIC_FLOW: {
  my $setup = validate_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op (('create')) {
    my ($_should_skip, $_reason) = BluefinShieldconexTestRunner::is_control_skipped(
      'entityOp', "validate." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('validate: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
  }
  my $client = $setup->{client};
  my %V;

  # CREATE
  $V{validate_ref01_ent} = $client->Validate(undef);
  $V{validate_ref01_data} = BluefinShieldconexHelpers::to_map(BluefinShieldconexHelpers::gp(
    BluefinShieldconexHelpers::gpath($setup->{data}, 'new.validate'), 'validate_ref01'));

  $V{validate_ref01_data_result} = $V{validate_ref01_ent}->create($V{validate_ref01_data}, undef);
  $V{validate_ref01_data} = BluefinShieldconexHelpers::to_map(ref($V{validate_ref01_data_result}) && $V{validate_ref01_data_result}->can('data_get') ? $V{validate_ref01_data_result}->data_get : $V{validate_ref01_data_result});
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

  # Whether *_ENTID supplied the idmap, read before env_override consumes
  # it: without it, the ids a live flow binds are the fixture's synthetic ones.
  my $entid_env_raw = $ENV{'BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = BluefinShieldconexTestRunner::env_override({
    'BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID' => $idmap,
    'BLUEFIN_SHIELDCONEX_TEST_LIVE' => 'FALSE',
    'BLUEFIN_SHIELDCONEX_TEST_EXPLAIN' => 'FALSE',
    'BLUEFIN_SHIELDCONEX_APIKEY' => '',
  });

  my $idmap_resolved = BluefinShieldconexHelpers::to_map($env->{'BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID'});
  if (!defined $idmap_resolved) {
    $idmap_resolved = BluefinShieldconexHelpers::to_map($idmap);
  }

  if ((($env->{'BLUEFIN_SHIELDCONEX_TEST_LIVE'}) || '') eq 'TRUE') {
    my $merged_opts = Voxgig::Struct::merge([
      # FIRST, so the generated fields below win: sdk-test-control.json's
      # test.client.options adds to the live client, it does not redirect it.
      BluefinShieldconexTestRunner::live_client_options(),
      {
        'apikey' => $env->{'BLUEFIN_SHIELDCONEX_APIKEY'},
      },
      (Voxgig::Struct::ismap($extra) ? $extra : {}),
    ]);
    $client = BluefinShieldconexSDK->new(BluefinShieldconexHelpers::to_map($merged_opts));
  }

  my $live = ((($env->{'BLUEFIN_SHIELDCONEX_TEST_LIVE'}) || '') eq 'TRUE') ? 1 : 0;
  return {
    'client' => $client,
    'data' => $entity_data,
    'idmap' => $idmap_resolved,
    'env' => $env,
    'explain' => ((($env->{'BLUEFIN_SHIELDCONEX_TEST_EXPLAIN'}) || '') eq 'TRUE') ? 1 : 0,
    'live' => $live,
    'synthetic_only' => ($live && !$idmap_overridden) ? 1 : 0,
    'now' => BluefinShieldconexHelpers::now_ms(),
  };
}

done_testing();
