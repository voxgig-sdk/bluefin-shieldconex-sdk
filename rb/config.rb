# BluefinShieldconex SDK configuration

module BluefinShieldconexConfig
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "BluefinShieldconex",
        "slug" => "bluefin-shieldconex",
        "version" => "0.1.1",
        "target" => "rb",
      },
      "feature" => {
        "audit" => {
          "options" => {
            "active" => false,
            "actor" => "anonymous",
            "max" => 1000,
          },
          "optspec" => {
            "now" => "`$FUNCTION`",
            "sink" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "none",
        },
        "clienttrack" => {
          "options" => {
            "active" => false,
            "clientVersion" => "0.0.1",
          },
          "optspec" => {
            "clientName" => "`$STRING`",
            "clientVersion" => "`$STRING`",
            "headers" => "`$MAP`",
            "idgen" => "`$FUNCTION`",
            "sessionId" => "`$STRING`",
          },
          "strict" => false,
          "transport" => "none",
        },
        "debug" => {
          "options" => {
            "active" => false,
            "max" => 100,
            "redact" => [
              "authorization",
              "cookie",
              "set-cookie",
              "api-key",
              "apikey",
              "x-api-key",
              "idempotency-key",
            ],
          },
          "optspec" => {
            "now" => "`$FUNCTION`",
            "onEntry" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "none",
        },
        "idempotency" => {
          "options" => {
            "active" => false,
            "header" => "Idempotency-Key",
            "methods" => [
              "POST",
              "PUT",
              "PATCH",
              "DELETE",
            ],
            "ops" => [
              "create",
              "update",
              "remove",
            ],
          },
          "optspec" => {
            "keygen" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "none",
        },
        "log" => {
          "options" => {
            "active" => true,
          },
          "optspec" => {
            "level" => "`$STRING`",
            "logger" => "`$ANY`",
          },
          "strict" => false,
          "transport" => "none",
        },
        "metrics" => {
          "options" => {
            "active" => false,
          },
          "optspec" => {
            "now" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "none",
        },
        "paging" => {
          "options" => {
            "active" => false,
            "afterVar" => "after",
            "cursorParam" => "cursor",
            "firstVar" => "first",
            "limitParam" => "limit",
            "pageParam" => "page",
            "startPage" => 1,
          },
          "optspec" => {
            "limit" => "`$NUMBER`",
            "ops" => "`$LIST`",
          },
          "strict" => false,
          "transport" => "none",
        },
        "ratelimit" => {
          "options" => {
            "active" => false,
            "burst" => 5,
            "rate" => 5,
          },
          "optspec" => {
            "now" => "`$FUNCTION`",
            "sleep" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
        "retry" => {
          "options" => {
            "active" => false,
            "factor" => 2,
            "maxDelay" => 2000,
            "minDelay" => 50,
            "retries" => 2,
            "statuses" => [
              408,
              425,
              429,
              500,
              502,
              503,
              504,
            ],
          },
          "optspec" => {
            "jitter" => "`$BOOLEAN`",
            "sleep" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
        "telemetry" => {
          "options" => {
            "active" => false,
          },
          "optspec" => {
            "exporter" => "`$FUNCTION`",
            "headers" => "`$MAP`",
            "idgen" => "`$FUNCTION`",
            "now" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "none",
        },
        "test" => {
          "options" => {
            "active" => false,
          },
          "optspec" => {
            "entity" => "`$MAP`",
            "net" => "`$MAP`",
          },
          "strict" => false,
          "transport" => "base",
        },
        "timeout" => {
          "options" => {
            "active" => false,
            "ms" => 30000,
          },
          "optspec" => {
            "clearTimer" => "`$FUNCTION`",
            "setTimer" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
      },
      "options" => {
        "base" => "https://secure-cert.shieldconex.com/api",
        "auth" => {
          "prefix" => "Basic",
          "basic" => true,
        },
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "detokenize" => {},
          "tokenize" => {},
          "tokenize_batch" => {},
          "tokenize_read" => {},
          "validate" => {},
        },
      },
      "entity" => {
        "detokenize" => {
          "fields" => [
            {
              "name" => "batches",
              "title" => "Batches",
              "type" => "`$ARRAY`",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
            },
            {
              "name" => "bfid",
              "title" => "Bfid",
              "type" => "`$STRING`",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "short" => "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
            },
            {
              "name" => "messageId",
              "title" => "Message Id",
              "type" => "`$STRING`",
              "short" => "Message Id",
            },
            {
              "name" => "name",
              "title" => "Name",
              "type" => "`$STRING`",
              "short" => "Field Name.",
            },
            {
              "name" => "reference",
              "title" => "Reference",
              "type" => "`$STRING`",
              "short" => "Request Reference.",
            },
            {
              "name" => "value",
              "title" => "Value",
              "type" => "`$STRING`",
              "short" => "Field Value.",
            },
            {
              "name" => "values",
              "title" => "Values",
              "type" => "`$ARRAY`",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
            },
          ],
          "name" => "detokenize",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/detokenize",
                  "segments" => [
                    {
                      "lit" => "tokenization",
                    },
                    {
                      "lit" => "batch",
                    },
                    {
                      "lit" => "detokenize",
                    },
                  ],
                  "parts" => [
                    "tokenization",
                    "batch",
                    "detokenize",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {},
                  "select" => {},
                },
                {
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/detokenize",
                  "segments" => [
                    {
                      "lit" => "tokenization",
                    },
                    {
                      "lit" => "detokenize",
                    },
                  ],
                  "parts" => [
                    "tokenization",
                    "detokenize",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {},
                  "select" => {},
                },
              ],
            },
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/healthcheck/detokenize",
                  "segments" => [
                    {
                      "lit" => "healthcheck",
                    },
                    {
                      "lit" => "detokenize",
                    },
                  ],
                  "parts" => [
                    "healthcheck",
                    "detokenize",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.values`",
                  },
                  "args" => {
                    "query" => [
                      {
                        "name" => "bfid",
                        "orig" => "bfid",
                        "type" => "`$STRING`",
                        "kind" => "query",
                        "reqd" => true,
                      },
                      {
                        "name" => "field_name",
                        "orig" => "field_name",
                        "type" => "`$STRING`",
                        "kind" => "query",
                      },
                      {
                        "name" => "field_value",
                        "orig" => "field_value",
                        "type" => "`$STRING`",
                        "kind" => "query",
                      },
                      {
                        "name" => "reference",
                        "orig" => "reference",
                        "type" => "`$STRING`",
                        "kind" => "query",
                      },
                    ],
                  },
                  "select" => {
                    "exist" => [
                      "bfid",
                      "field_name",
                      "field_value",
                      "reference",
                    ],
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "tokenize" => {
          "fields" => [
            {
              "name" => "batches",
              "title" => "Batches",
              "type" => "`$ARRAY`",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
            },
            {
              "name" => "bfid",
              "title" => "Bfid",
              "type" => "`$STRING`",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "short" => "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
            },
            {
              "name" => "messageId",
              "title" => "Message Id",
              "type" => "`$STRING`",
              "short" => "Message Id",
            },
            {
              "name" => "name",
              "title" => "Name",
              "type" => "`$STRING`",
              "short" => "Field Name.",
            },
            {
              "name" => "reference",
              "title" => "Reference",
              "type" => "`$STRING`",
              "short" => "Request Reference.",
            },
            {
              "name" => "templateRef",
              "title" => "Template Ref",
              "type" => "`$STRING`",
              "req" => true,
              "short" => "Template Reference",
            },
            {
              "name" => "value",
              "title" => "Value",
              "type" => "`$STRING`",
              "short" => "Field Value.",
            },
            {
              "name" => "values",
              "title" => "Values",
              "type" => "`$ARRAY`",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
            },
          ],
          "name" => "tokenize",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/tokenize",
                  "segments" => [
                    {
                      "lit" => "tokenization",
                    },
                    {
                      "lit" => "batch",
                    },
                    {
                      "lit" => "tokenize",
                    },
                  ],
                  "parts" => [
                    "tokenization",
                    "batch",
                    "tokenize",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {
                    "query" => [
                      {
                        "name" => "omit",
                        "orig" => "omit",
                        "type" => "`$NUMBER`",
                        "kind" => "query",
                      },
                    ],
                  },
                  "select" => {
                    "exist" => [
                      "omit",
                    ],
                  },
                },
                {
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/tokenize",
                  "segments" => [
                    {
                      "lit" => "tokenization",
                    },
                    {
                      "lit" => "tokenize",
                    },
                  ],
                  "parts" => [
                    "tokenization",
                    "tokenize",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {
                    "query" => [
                      {
                        "name" => "omit",
                        "orig" => "omit",
                        "type" => "`$NUMBER`",
                        "kind" => "query",
                      },
                    ],
                  },
                  "select" => {
                    "exist" => [
                      "omit",
                    ],
                  },
                },
                {
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/delete",
                  "segments" => [
                    {
                      "lit" => "tokenization",
                    },
                    {
                      "lit" => "delete",
                    },
                  ],
                  "parts" => [
                    "tokenization",
                    "delete",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {},
                  "select" => {},
                },
              ],
            },
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/healthcheck/tokenize",
                  "segments" => [
                    {
                      "lit" => "healthcheck",
                    },
                    {
                      "lit" => "tokenize",
                    },
                  ],
                  "parts" => [
                    "healthcheck",
                    "tokenize",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.values`",
                  },
                  "args" => {
                    "query" => [
                      {
                        "name" => "field_name",
                        "orig" => "field_name",
                        "type" => "`$STRING`",
                        "kind" => "query",
                      },
                      {
                        "name" => "field_value",
                        "orig" => "field_value",
                        "type" => "`$STRING`",
                        "kind" => "query",
                      },
                      {
                        "name" => "reference",
                        "orig" => "reference",
                        "type" => "`$STRING`",
                        "kind" => "query",
                      },
                      {
                        "name" => "template_ref",
                        "orig" => "template_ref",
                        "type" => "`$STRING`",
                        "kind" => "query",
                        "reqd" => true,
                      },
                    ],
                  },
                  "select" => {
                    "exist" => [
                      "field_name",
                      "field_value",
                      "reference",
                      "template_ref",
                    ],
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "tokenize_batch" => {
          "fields" => [
            {
              "name" => "batches",
              "title" => "Batches",
              "type" => "`$ARRAY`",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
            },
            {
              "name" => "messageId",
              "title" => "Message Id",
              "type" => "`$STRING`",
              "short" => "Message Id",
            },
            {
              "name" => "reference",
              "title" => "Reference",
              "type" => "`$STRING`",
              "short" => "Request Reference.",
            },
          ],
          "name" => "tokenize_batch",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/delete",
                  "segments" => [
                    {
                      "lit" => "tokenization",
                    },
                    {
                      "lit" => "batch",
                    },
                    {
                      "lit" => "delete",
                    },
                  ],
                  "parts" => [
                    "tokenization",
                    "batch",
                    "delete",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {},
                  "select" => {},
                },
                {
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/read",
                  "segments" => [
                    {
                      "lit" => "tokenization",
                    },
                    {
                      "lit" => "batch",
                    },
                    {
                      "lit" => "read",
                    },
                  ],
                  "parts" => [
                    "tokenization",
                    "batch",
                    "read",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {},
                  "select" => {},
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "tokenize_read" => {
          "fields" => [
            {
              "name" => "bfid",
              "title" => "Bfid",
              "type" => "`$STRING`",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "short" => "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
            },
            {
              "name" => "messageId",
              "title" => "Message Id",
              "type" => "`$STRING`",
              "short" => "Message Id",
            },
            {
              "name" => "reference",
              "title" => "Reference",
              "type" => "`$STRING`",
              "short" => "Request Reference.",
            },
            {
              "name" => "state",
              "title" => "State",
              "type" => "`$OBJECT`",
              "short" => "Tokenized State Data (if available)",
            },
            {
              "name" => "values",
              "title" => "Values",
              "type" => "`$ARRAY`",
            },
          ],
          "name" => "tokenize_read",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/read",
                  "segments" => [
                    {
                      "lit" => "tokenization",
                    },
                    {
                      "lit" => "read",
                    },
                  ],
                  "parts" => [
                    "tokenization",
                    "read",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {},
                  "select" => {},
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "validate" => {
          "fields" => [
            {
              "name" => "messageId",
              "title" => "Message Id",
              "type" => "`$STRING`",
              "short" => "Message Id",
            },
            {
              "name" => "reference",
              "title" => "Reference",
              "type" => "`$STRING`",
              "short" => "Request Reference.",
            },
            {
              "name" => "templateRef",
              "title" => "Template Ref",
              "type" => "`$STRING`",
              "req" => true,
              "short" => "Template Reference.",
            },
          ],
          "name" => "validate",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/partner/validate",
                  "segments" => [
                    {
                      "lit" => "partner",
                    },
                    {
                      "lit" => "validate",
                    },
                  ],
                  "parts" => [
                    "partner",
                    "validate",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {},
                  "select" => {},
                },
                {
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/template/validate",
                  "segments" => [
                    {
                      "lit" => "template",
                    },
                    {
                      "lit" => "validate",
                    },
                  ],
                  "parts" => [
                    "template",
                    "validate",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {},
                  "select" => {},
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    BluefinShieldconexFeatures.make_feature(name)
  end
end
