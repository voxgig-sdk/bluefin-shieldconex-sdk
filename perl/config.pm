# BluefinShieldconex SDK configuration

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/lib/Voxgig/Struct.pm"));

package BluefinShieldconexConfig;

# GENERATED from the API model - do not edit by hand. Parsed fresh on
# each call so callers can safely mutate their copy.
my $CONFIG_JSON = <<'END_CONFIG_JSON';
{
  "main": {
    "name": "BluefinShieldconex",
    "slug": "bluefin-shieldconex",
    "version": "0.0.1",
    "target": "perl"
  },
  "feature": {
    "test": {
      "options": {
        "active": false
      }
    }
  },
  "options": {
    "base": "https://secure-cert.shieldconex.com/api",
    "auth": {
      "prefix": "Basic"
    },
    "headers": {
      "content-type": "application/json"
    },
    "entity": {
      "detokenize": {},
      "tokenize": {},
      "tokenize_batch": {},
      "tokenize_read": {},
      "validate": {}
    }
  },
  "entity": {
    "detokenize": {
      "fields": [
        {
          "name": "batches",
          "op": {
            "create": {
              "req": true,
              "type": "`$ARRAY`"
            }
          },
          "type": "`$ARRAY`"
        },
        {
          "name": "bfid",
          "op": {
            "create": {
              "req": true,
              "type": "`$STRING`"
            }
          },
          "short": "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
          "type": "`$STRING`"
        },
        {
          "name": "messageId",
          "short": "Message Id",
          "type": "`$STRING`"
        },
        {
          "name": "name",
          "short": "Field Name.",
          "type": "`$STRING`"
        },
        {
          "name": "reference",
          "short": "Request Reference.",
          "type": "`$STRING`"
        },
        {
          "name": "value",
          "short": "Field Value.",
          "type": "`$STRING`"
        },
        {
          "name": "values",
          "op": {
            "create": {
              "req": true,
              "type": "`$ARRAY`"
            }
          },
          "type": "`$ARRAY`"
        }
      ],
      "name": "detokenize",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/tokenization/batch/detokenize",
              "parts": [
                "tokenization",
                "batch",
                "detokenize"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/tokenization/detokenize",
              "parts": [
                "tokenization",
                "detokenize"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "query": [
                  {
                    "kind": "query",
                    "name": "bfid",
                    "orig": "bfid",
                    "reqd": true,
                    "type": "`$STRING`"
                  },
                  {
                    "kind": "query",
                    "name": "field_name",
                    "orig": "field_name",
                    "type": "`$STRING`"
                  },
                  {
                    "kind": "query",
                    "name": "field_value",
                    "orig": "field_value",
                    "type": "`$STRING`"
                  },
                  {
                    "kind": "query",
                    "name": "reference",
                    "orig": "reference",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/healthcheck/detokenize",
              "parts": [
                "healthcheck",
                "detokenize"
              ],
              "select": {
                "exist": [
                  "bfid",
                  "field_name",
                  "field_value",
                  "reference"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "tokenize": {
      "fields": [
        {
          "name": "batches",
          "op": {
            "create": {
              "req": true,
              "type": "`$ARRAY`"
            }
          },
          "type": "`$ARRAY`"
        },
        {
          "name": "bfid",
          "op": {
            "create": {
              "req": true,
              "type": "`$STRING`"
            }
          },
          "short": "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
          "type": "`$STRING`"
        },
        {
          "name": "messageId",
          "short": "Message Id",
          "type": "`$STRING`"
        },
        {
          "name": "name",
          "short": "Field Name.",
          "type": "`$STRING`"
        },
        {
          "name": "reference",
          "short": "Request Reference.",
          "type": "`$STRING`"
        },
        {
          "name": "templateRef",
          "req": true,
          "short": "Template Reference",
          "type": "`$STRING`"
        },
        {
          "name": "value",
          "short": "Field Value.",
          "type": "`$STRING`"
        },
        {
          "name": "values",
          "op": {
            "create": {
              "req": true,
              "type": "`$ARRAY`"
            }
          },
          "type": "`$ARRAY`"
        }
      ],
      "name": "tokenize",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "args": {
                "query": [
                  {
                    "kind": "query",
                    "name": "omit",
                    "orig": "omit",
                    "type": "`$NUMBER`"
                  }
                ]
              },
              "kind": "http",
              "method": "POST",
              "orig": "/tokenization/batch/tokenize",
              "parts": [
                "tokenization",
                "batch",
                "tokenize"
              ],
              "select": {
                "exist": [
                  "omit"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {
                "query": [
                  {
                    "kind": "query",
                    "name": "omit",
                    "orig": "omit",
                    "type": "`$NUMBER`"
                  }
                ]
              },
              "kind": "http",
              "method": "POST",
              "orig": "/tokenization/tokenize",
              "parts": [
                "tokenization",
                "tokenize"
              ],
              "select": {
                "exist": [
                  "omit"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/tokenization/delete",
              "parts": [
                "tokenization",
                "delete"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "query": [
                  {
                    "kind": "query",
                    "name": "field_name",
                    "orig": "field_name",
                    "type": "`$STRING`"
                  },
                  {
                    "kind": "query",
                    "name": "field_value",
                    "orig": "field_value",
                    "type": "`$STRING`"
                  },
                  {
                    "kind": "query",
                    "name": "reference",
                    "orig": "reference",
                    "type": "`$STRING`"
                  },
                  {
                    "kind": "query",
                    "name": "template_ref",
                    "orig": "template_ref",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/healthcheck/tokenize",
              "parts": [
                "healthcheck",
                "tokenize"
              ],
              "select": {
                "exist": [
                  "field_name",
                  "field_value",
                  "reference",
                  "template_ref"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "tokenize_batch": {
      "fields": [
        {
          "name": "batches",
          "op": {
            "create": {
              "req": true,
              "type": "`$ARRAY`"
            }
          },
          "type": "`$ARRAY`"
        },
        {
          "name": "messageId",
          "short": "Message Id",
          "type": "`$STRING`"
        },
        {
          "name": "reference",
          "short": "Request Reference.",
          "type": "`$STRING`"
        }
      ],
      "name": "tokenize_batch",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/tokenization/batch/delete",
              "parts": [
                "tokenization",
                "batch",
                "delete"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/tokenization/batch/read",
              "parts": [
                "tokenization",
                "batch",
                "read"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "tokenize_read": {
      "fields": [
        {
          "name": "bfid",
          "op": {
            "create": {
              "req": true,
              "type": "`$STRING`"
            }
          },
          "short": "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
          "type": "`$STRING`"
        },
        {
          "name": "messageId",
          "short": "Message Id",
          "type": "`$STRING`"
        },
        {
          "name": "reference",
          "short": "Request Reference.",
          "type": "`$STRING`"
        },
        {
          "name": "state",
          "short": "Tokenized State Data (if available)",
          "type": "`$OBJECT`"
        },
        {
          "name": "values",
          "type": "`$ARRAY`"
        }
      ],
      "name": "tokenize_read",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/tokenization/read",
              "parts": [
                "tokenization",
                "read"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "validate": {
      "fields": [
        {
          "name": "messageId",
          "short": "Message Id",
          "type": "`$STRING`"
        },
        {
          "name": "reference",
          "short": "Request Reference.",
          "type": "`$STRING`"
        },
        {
          "name": "templateRef",
          "req": true,
          "short": "Template Reference.",
          "type": "`$STRING`"
        }
      ],
      "name": "validate",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/partner/validate",
              "parts": [
                "partner",
                "validate"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/template/validate",
              "parts": [
                "template",
                "validate"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    }
  }
}
END_CONFIG_JSON

sub make_config {
  return Voxgig::Struct::parse_json($CONFIG_JSON);
}

# SHARED CONFIG (sdkgen rung L2).
#
# The SDK reads the config on every request and never writes to it, so one
# instance is shared by every client rather than rebuilt per client - the
# difference between parsing the embedded JSON once and once per client.
#
# The returned structure is SHARED: treat it as read-only. Callers that need to
# mutate should use make_config, which always parses a fresh copy.
my $SHARED_CONFIG;

sub shared_config {
  $SHARED_CONFIG = make_config() unless defined $SHARED_CONFIG;
  return $SHARED_CONFIG;
}

sub make_feature {
  my ($name) = @_;
  require(Cwd::abs_path("$__dir/features.pm"));
  return BluefinShieldconexFeatures::make_feature($name);
}

1;
