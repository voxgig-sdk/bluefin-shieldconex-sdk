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
    "name": "BluefinShieldconex"
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
          "type": "`$STRING`"
        },
        {
          "name": "messageId",
          "type": "`$STRING`"
        },
        {
          "name": "name",
          "type": "`$STRING`"
        },
        {
          "name": "reference",
          "type": "`$STRING`"
        },
        {
          "name": "value",
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
          "type": "`$STRING`"
        },
        {
          "name": "messageId",
          "type": "`$STRING`"
        },
        {
          "name": "name",
          "type": "`$STRING`"
        },
        {
          "name": "reference",
          "type": "`$STRING`"
        },
        {
          "name": "templateRef",
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "value",
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
          "type": "`$STRING`"
        },
        {
          "name": "reference",
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
          "type": "`$STRING`"
        },
        {
          "name": "messageId",
          "type": "`$STRING`"
        },
        {
          "name": "reference",
          "type": "`$STRING`"
        },
        {
          "name": "state",
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
          "type": "`$STRING`"
        },
        {
          "name": "reference",
          "type": "`$STRING`"
        },
        {
          "name": "templateRef",
          "req": true,
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

sub make_feature {
  my ($name) = @_;
  require(Cwd::abs_path("$__dir/features.pm"));
  return BluefinShieldconexFeatures::make_feature($name);
}

1;
