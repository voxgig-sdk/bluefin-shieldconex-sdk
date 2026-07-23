#!perl
# Detokenize direct test

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Cwd ();

use BluefinShieldconexSDK;
require(Cwd::abs_path("$FindBin::Bin/runner.pm"));

DIRECT_LIST: {
  my $setup = detokenize_direct_setup([
    { 'id' => 'direct01' },
    { 'id' => 'direct02' },
  ]);
  my ($_should_skip, $_reason) = BluefinShieldconexTestRunner::is_control_skipped(
    'direct', 'direct-list-detokenize', $setup->{live} ? 'live' : 'unit');
  if ($_should_skip) {
    note($_reason || 'skipped via sdk-test-control.json');
    pass('direct-list-detokenize: skipped via sdk-test-control.json');
    last DIRECT_LIST;
  }
  my $client = $setup->{client};

  my $result = $client->direct({
    'path' => 'healthcheck/detokenize',
    'method' => 'GET',
    'params' => {},
  });
  if ($setup->{live}) {
    # Live mode is lenient: synthetic IDs frequently 4xx and the list-
    # response shape varies wildly across public APIs. Skip rather than
    # fail when the call doesn't return a usable list.
    if (defined $result->{err}) {
      note("list call failed (likely synthetic IDs against live API): $result->{err}");
      pass('direct-list-detokenize: skipped (live)');
      last DIRECT_LIST;
    }
    unless ($result->{ok}) {
      note('list call not ok (likely synthetic IDs against live API)');
      pass('direct-list-detokenize: skipped (live)');
      last DIRECT_LIST;
    }
    my $status = BluefinShieldconexHelpers::to_int($result->{status});
    if ($status < 200 || $status >= 300) {
      note("expected 2xx status, got $status");
      pass('direct-list-detokenize: skipped (live)');
      last DIRECT_LIST;
    }
    pass('direct-list-detokenize: live ok');
  }
  else {
    ok(!defined $result->{err}, 'direct-list-detokenize: no error');
    ok($result->{ok}, 'direct-list-detokenize: ok');
    is(BluefinShieldconexHelpers::to_int($result->{status}), 200, 'direct-list-detokenize: status');
    ok(Voxgig::Struct::islist($result->{data}), 'direct-list-detokenize: data is array');
    is(scalar @{ $result->{data} }, 2, 'direct-list-detokenize: data length');
    is(scalar @{ $setup->{calls} }, 1, 'direct-list-detokenize: 1 call');
  }
}


sub detokenize_direct_setup {
  my ($mockres) = @_;
  BluefinShieldconexTestRunner::load_env_local();

  my $calls = [];

  my $env = BluefinShieldconexTestRunner::env_override({
    'BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID' => {},
    'BLUEFINSHIELDCONEX_TEST_LIVE' => 'FALSE',
    'BLUEFINSHIELDCONEX_APIKEY' => 'NONE',
  });

  my $live = ((($env->{'BLUEFINSHIELDCONEX_TEST_LIVE'}) || '') eq 'TRUE') ? 1 : 0;

  if ($live) {
    my $client = BluefinShieldconexSDK->new({
      'apikey' => $env->{'BLUEFINSHIELDCONEX_APIKEY'},
    });
    return {
      'client' => $client,
      'calls' => $calls,
      'live' => 1,
      'idmap' => {},
    };
  }

  my $mock_fetch = sub {
    my ($url, $init) = @_;
    push @$calls, { 'url' => $url, 'init' => $init };
    return ({
      'status' => 200,
      'statusText' => 'OK',
      'headers' => {},
      'json' => sub {
        return defined $mockres ? $mockres : { 'id' => 'direct01' };
      },
      'body' => 'mock',
    }, undef);
  };

  my $client = BluefinShieldconexSDK->new({
    'base' => 'http://localhost:8080',
    'system' => {
      'fetch' => $mock_fetch,
    },
  });

  return {
    'client' => $client,
    'calls' => $calls,
    'live' => 0,
    'idmap' => {},
  };
}

done_testing();
