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
        "version" => "0.0.1",
        "target" => "rb",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
        },
      },
      "options" => {
        "base" => "https://secure-cert.shieldconex.com/api",
        "auth" => {
          "prefix" => "Basic",
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
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
              "type" => "`$ARRAY`",
            },
            {
              "name" => "bfid",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "short" => "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
              "type" => "`$STRING`",
            },
            {
              "name" => "messageId",
              "short" => "Message Id",
              "type" => "`$STRING`",
            },
            {
              "name" => "name",
              "short" => "Field Name.",
              "type" => "`$STRING`",
            },
            {
              "name" => "reference",
              "short" => "Request Reference.",
              "type" => "`$STRING`",
            },
            {
              "name" => "value",
              "short" => "Field Value.",
              "type" => "`$STRING`",
            },
            {
              "name" => "values",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
              "type" => "`$ARRAY`",
            },
          ],
          "name" => "detokenize",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/detokenize",
                  "parts" => [
                    "tokenization",
                    "batch",
                    "detokenize",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/detokenize",
                  "parts" => [
                    "tokenization",
                    "detokenize",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "bfid",
                        "orig" => "bfid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "field_name",
                        "orig" => "field_name",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "field_value",
                        "orig" => "field_value",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "reference",
                        "orig" => "reference",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/healthcheck/detokenize",
                  "parts" => [
                    "healthcheck",
                    "detokenize",
                  ],
                  "select" => {
                    "exist" => [
                      "bfid",
                      "field_name",
                      "field_value",
                      "reference",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
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
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
              "type" => "`$ARRAY`",
            },
            {
              "name" => "bfid",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "short" => "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
              "type" => "`$STRING`",
            },
            {
              "name" => "messageId",
              "short" => "Message Id",
              "type" => "`$STRING`",
            },
            {
              "name" => "name",
              "short" => "Field Name.",
              "type" => "`$STRING`",
            },
            {
              "name" => "reference",
              "short" => "Request Reference.",
              "type" => "`$STRING`",
            },
            {
              "name" => "templateRef",
              "req" => true,
              "short" => "Template Reference",
              "type" => "`$STRING`",
            },
            {
              "name" => "value",
              "short" => "Field Value.",
              "type" => "`$STRING`",
            },
            {
              "name" => "values",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
              "type" => "`$ARRAY`",
            },
          ],
          "name" => "tokenize",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "omit",
                        "orig" => "omit",
                        "type" => "`$NUMBER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/tokenize",
                  "parts" => [
                    "tokenization",
                    "batch",
                    "tokenize",
                  ],
                  "select" => {
                    "exist" => [
                      "omit",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "omit",
                        "orig" => "omit",
                        "type" => "`$NUMBER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/tokenize",
                  "parts" => [
                    "tokenization",
                    "tokenize",
                  ],
                  "select" => {
                    "exist" => [
                      "omit",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/delete",
                  "parts" => [
                    "tokenization",
                    "delete",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "field_name",
                        "orig" => "field_name",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "field_value",
                        "orig" => "field_value",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "reference",
                        "orig" => "reference",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "template_ref",
                        "orig" => "template_ref",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/healthcheck/tokenize",
                  "parts" => [
                    "healthcheck",
                    "tokenize",
                  ],
                  "select" => {
                    "exist" => [
                      "field_name",
                      "field_value",
                      "reference",
                      "template_ref",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
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
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
              "type" => "`$ARRAY`",
            },
            {
              "name" => "messageId",
              "short" => "Message Id",
              "type" => "`$STRING`",
            },
            {
              "name" => "reference",
              "short" => "Request Reference.",
              "type" => "`$STRING`",
            },
          ],
          "name" => "tokenize_batch",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/delete",
                  "parts" => [
                    "tokenization",
                    "batch",
                    "delete",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/read",
                  "parts" => [
                    "tokenization",
                    "batch",
                    "read",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
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
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "short" => "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
              "type" => "`$STRING`",
            },
            {
              "name" => "messageId",
              "short" => "Message Id",
              "type" => "`$STRING`",
            },
            {
              "name" => "reference",
              "short" => "Request Reference.",
              "type" => "`$STRING`",
            },
            {
              "name" => "state",
              "short" => "Tokenized State Data (if available)",
              "type" => "`$OBJECT`",
            },
            {
              "name" => "values",
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
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/read",
                  "parts" => [
                    "tokenization",
                    "read",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
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
              "short" => "Message Id",
              "type" => "`$STRING`",
            },
            {
              "name" => "reference",
              "short" => "Request Reference.",
              "type" => "`$STRING`",
            },
            {
              "name" => "templateRef",
              "req" => true,
              "short" => "Template Reference.",
              "type" => "`$STRING`",
            },
          ],
          "name" => "validate",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/partner/validate",
                  "parts" => [
                    "partner",
                    "validate",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/template/validate",
                  "parts" => [
                    "template",
                    "validate",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
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
