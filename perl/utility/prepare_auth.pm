# BluefinShieldconex SDK utility: prepare_auth

use strict;
use warnings;

use File::Basename ();
use Cwd ();
use MIME::Base64 ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/../lib/Voxgig/Struct.pm"));
require(Cwd::abs_path("$__dir/../core/helpers.pm"));

package BluefinShieldconexUtilities;

our %REGISTRY;

my $CRED_NAME = 'authorization';
my $OPTION_APIKEY = 'apikey';
my $OPTION_SECRET = 'secret';
my $NOT_FOUND = '__NOTFOUND__';

# The client's auth.name option, when set, replaces the name the API declares.
my $auth_name = sub {
  my ($options) = @_;
  my $name = BluefinShieldconexHelpers::gpath($options, 'auth.name');
  return (defined $name && !ref $name && '' ne $name) ? lc($name) : $CRED_NAME;
};

$REGISTRY{prepare_auth} = sub {
  my ($ctx) = @_;
  my $spec = $ctx->{spec};
  return (undef, $ctx->make_error('auth_no_spec',
    'Expected context spec property to be defined.')) unless $spec;

  my $headers = $spec->{headers};
  my $options = $ctx->{client}->options_map;

  # Public APIs that need no auth omit the options.auth block entirely.
  if (!defined BluefinShieldconexHelpers::gp($options, 'auth')) {
    delete $headers->{$CRED_NAME};
    return ($spec, undef);
  }

  my $name = $auth_name->($options);

  # A credential left under the declared name would travel beside the renamed one.
  if ($name ne $CRED_NAME) {
    delete $headers->{$CRED_NAME};
  }

  my $apikey = Voxgig::Struct::getprop($options, $OPTION_APIKEY, $NOT_FOUND);

  # True HTTP Basic Auth joins the two credentials, base64-encoded - a single
  # token in the header (the branch below) can never authenticate against
  # an API that actually checks `Authorization: Basic base64(user:pass)`.
  # The password may be empty (RFC 7617): Lob, for one, documents the key as
  # the user with a blank password (`curl -u key:`).
  if (BluefinShieldconexHelpers::is_true(BluefinShieldconexHelpers::gpath($options, 'auth.basic'))) {
    my $secret = Voxgig::Struct::getprop($options, $OPTION_SECRET, $NOT_FOUND);

    my $no_apikey = !defined $apikey || Voxgig::Struct::is_none($apikey)
      || Voxgig::Struct::is_jnull($apikey)
      || (!ref $apikey && ($apikey eq $NOT_FOUND || $apikey eq ''));
    my $no_secret = !defined $secret || Voxgig::Struct::is_none($secret)
      || Voxgig::Struct::is_jnull($secret)
      || (!ref $secret && ($secret eq $NOT_FOUND || $secret eq ''));

    if ($no_apikey) {
      delete $headers->{$name};
    }
    else {
      my $auth_prefix = BluefinShieldconexHelpers::gpath($options, 'auth.prefix');
      $auth_prefix = '' unless defined $auth_prefix && !ref $auth_prefix;
      # '' as the eol: encode_base64 wraps at 76 columns by default, and a
      # newline inside a header value is not a header value.
      my $pass = $no_secret ? '' : $secret;
      my $b64 = MIME::Base64::encode_base64("$apikey:$pass", '');
      # The joined, encoded pair is a wire form neither credential's own
      # registration covers.
      $ctx->{utility}{clean_add}->($ctx, $b64);
      $headers->{$name} =
        ('' eq $auth_prefix) ? $b64 : "$auth_prefix $b64";
    }

    return ($spec, undef);
  }

  if (!defined $apikey || Voxgig::Struct::is_none($apikey)
    || Voxgig::Struct::is_jnull($apikey)
    || (!ref $apikey && ($apikey eq $NOT_FOUND || $apikey eq ''))) {
    delete $headers->{$name};
  }
  else {
    my $auth_prefix = BluefinShieldconexHelpers::gpath($options, 'auth.prefix');
    $auth_prefix = '' unless defined $auth_prefix && !ref $auth_prefix;
    my $apikey_val = (!ref $apikey) ? "$apikey" : '';
    # Empty prefix (raw apiKey credential) must not add a leading space.
    $headers->{$name} =
      ('' eq $auth_prefix) ? $apikey_val : "$auth_prefix $apikey_val";
  }

  return ($spec, undef);
};

1;
