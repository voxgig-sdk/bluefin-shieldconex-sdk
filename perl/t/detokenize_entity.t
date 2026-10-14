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

# main.kit.test.live.strict is true (the default is true): a live
# request that fails, or a live test missing an input it needs,
# fails the test.
# An account with no record for a test to read skips it either way.
use constant LIVE_STRICT => 1;

{
  my $testsdk = BluefinShieldconexSDK->test(undef, undef);
  my $ent = $testsdk->Detokenize(undef);
  ok(defined $ent, 'detokenize: create instance');
}

{
  package BluefinShieldconexEntityTestDetokenizeFailHook;
  our @ISA = ('BluefinShieldconexBaseFeature');

  sub new {
    my ($class) = @_;
    my $self = BluefinShieldconexBaseFeature::new($class);
    $self->{name} = 'failhook';
    $self->{unexpected} = 0;
    return $self;
  }

  sub init { }
  sub PreSpec { die "detokenize hook failed\n" }
  sub PreUnexpected { $_[0]->{unexpected}++; return }
}

{
  my $offline = { net => { offline => 1 } };
  my $died = !eval {
    my $next = BluefinShieldconexSDK->test($offline, undef)->Detokenize(undef)->stream('list', undef, undef);
    1 while defined $next->();
    1;
  };
  like($died ? "$@" : '', qr/offline/, 'detokenize: a failed stream raises');

  ok(eval {
    my $next = BluefinShieldconexSDK->test($offline, undef)->Detokenize(undef)
      ->stream('list', undef, { ctrl => { throw => 0 } });
    1 while defined $next->();
    1;
  }, 'detokenize: under throw false a failed stream ends');

  if (BluefinShieldconexConfig::shared_config()->{feature}{rbac}) {
    my $denied = BluefinShieldconexSDK->test(undef, { feature => { rbac => { active => 1, deny => 1 } } });
    my $denyerr = eval {
      my $next = $denied->Detokenize(undef)->stream('list', undef, undef);
      1 while defined $next->();
      undef;
    } // $@;
    is(ref $denyerr ? $denyerr->{code} : undef, 'rbac_denied',
      'detokenize: a denied stream raises');
  }
}

{
  my $explain = {};
  my $ctrl = { explain => $explain };
  my $next = BluefinShieldconexSDK->test(undef, undef)->Detokenize(undef)
    ->stream('list', undef, { ctrl => $ctrl });
  1 while defined $next->();
  is_deeply([sort keys %$ctrl], ['explain'], 'detokenize: the stream leaves the caller ctrl');
  ok($explain == $ctrl->{explain} && 0 < keys %$explain,
    'detokenize: the caller explain record is filled');
}

{
  my $hook = BluefinShieldconexEntityTestDetokenizeFailHook->new;
  my $client = BluefinShieldconexSDK->new({ feature => { test => { active => 1 } }, extend => [$hook] });

  my $err = eval { $client->Detokenize(undef)->list(undef, undef); undef } // $@;
  like("$err", qr/hook failed/, 'detokenize: a dying hook fails the operation');
  ok(0 < $hook->{unexpected}, 'detokenize: PreUnexpected fired');

  my $fired = $hook->{unexpected};
  my $out = eval { $client->Detokenize(undef)->list(undef, { throw => 0 }) };
  ok(!$@ && !defined $out, 'detokenize: under throw false the call returns undef');
  ok($fired < $hook->{unexpected}, 'detokenize: PreUnexpected fired under throw false');
}

{
  my $seed = { entity => { 'detokenize' => { l1 => { id => 'l1' }, l2 => { id => 'l2' } } } };
  my $items = BluefinShieldconexSDK->test($seed, undef)->Detokenize(undef)->list(undef, undef);
  # list resolves to one entity per record; data_get reads the record.
  is(scalar(@$items), 2, 'detokenize: list answers each seeded record');
  my $entities = grep {
    Scalar::Util::blessed($_) && $_->can('data_get') && Voxgig::Struct::ismap($_->data_get)
  } @$items;
  is($entities, 2, 'detokenize: each listed item is an entity carrying its record');
}

SKIP: {
  skip('feature not present in this SDK: validate', 1)
    unless BluefinShieldconexConfig::shared_config()->{feature}{validate};
  my $client = BluefinShieldconexSDK->test(undef, { feature => { validate => { active => 1 } } });
  my $err = eval { $client->Detokenize(undef)->list({ 'bfid' => 1 }, undef); undef } // $@;
  is(ref $err ? $err->{code} : undef, 'validate_failed',
    'detokenize: an invalid request fails with validate_failed');
}

BASIC_FLOW: {
  my $setup = detokenize_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op (('create', 'list')) {
    my ($_should_skip, $_reason) = BluefinShieldconexTestRunner::is_control_skipped(
      'entityOp', "detokenize." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('detokenize: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
  }
  my $client = $setup->{client};
  my %V;

  # CREATE
  $V{detokenize_ref01_ent} = $client->Detokenize(undef);
  $V{detokenize_ref01_data} = BluefinShieldconexHelpers::to_map(BluefinShieldconexHelpers::gp(
    BluefinShieldconexHelpers::gpath($setup->{data}, 'new.detokenize'), 'detokenize_ref01'));

  $V{detokenize_ref01_data_result} = $V{detokenize_ref01_ent}->create($V{detokenize_ref01_data}, undef);
  $V{detokenize_ref01_data} = BluefinShieldconexHelpers::to_map(ref($V{detokenize_ref01_data_result}) && $V{detokenize_ref01_data_result}->can('data_get') ? $V{detokenize_ref01_data_result}->data_get : $V{detokenize_ref01_data_result});
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

  # Whether *_ENTID supplied the idmap, read before env_override consumes
  # it: without it, the ids a live flow binds are the fixture's synthetic ones.
  my $entid_env_raw = $ENV{'BLUEFIN_SHIELDCONEX_TEST_DETOKENIZE_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = BluefinShieldconexTestRunner::env_override({
    'BLUEFIN_SHIELDCONEX_TEST_DETOKENIZE_ENTID' => $idmap,
    'BLUEFIN_SHIELDCONEX_TEST_LIVE' => 'FALSE',
    'BLUEFIN_SHIELDCONEX_TEST_EXPLAIN' => 'FALSE',
    'BLUEFIN_SHIELDCONEX_APIKEY' => '',
  });

  my $idmap_resolved = BluefinShieldconexHelpers::to_map($env->{'BLUEFIN_SHIELDCONEX_TEST_DETOKENIZE_ENTID'});
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
