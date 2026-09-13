
const { BaseFeature } = require('./feature/base/BaseFeature')
const { AuditFeature } = require('./feature/audit/AuditFeature')
const { ClienttrackFeature } = require('./feature/clienttrack/ClienttrackFeature')
const { IdempotencyFeature } = require('./feature/idempotency/IdempotencyFeature')
const { LogFeature } = require('./feature/log/LogFeature')
const { MetricsFeature } = require('./feature/metrics/MetricsFeature')
const { PagingFeature } = require('./feature/paging/PagingFeature')
const { RatelimitFeature } = require('./feature/ratelimit/RatelimitFeature')
const { RetryFeature } = require('./feature/retry/RetryFeature')
const { TelemetryFeature } = require('./feature/telemetry/TelemetryFeature')
const { TestFeature } = require('./feature/test/TestFeature')
const { TimeoutFeature } = require('./feature/timeout/TimeoutFeature')



const FEATURE_CLASS = {
   audit: AuditFeature,
 clienttrack: ClienttrackFeature,
 idempotency: IdempotencyFeature,
 log: LogFeature,
 metrics: MetricsFeature,
 paging: PagingFeature,
 ratelimit: RatelimitFeature,
 retry: RetryFeature,
 telemetry: TelemetryFeature,
 test: TestFeature,
 timeout: TimeoutFeature,

}


// Per-feature plugin DEFINITIONS (voxgig/plugin `Definition` values), from
// the model's active plugin groups. A feature that takes a `plugins` option
// (secrets over sekreto) reads its own entry; a feature with no plugins has
// none. Named requires above make each definition statically reachable, so
// an SDK carries exactly the plugin modules its model selects — the same
// leanness the old side-effect registry imports bought, without a registry.
//
// Read by SecretsFeature through a DEFERRED require of this module: the
// requires above make the pair circular, and this file replaces
// module.exports at the end of its body, so anything reading the map at
// module load would get undefined. See tm/js/src/feature/secrets.
const FEATURE_PLUGINS = {
  
}


class Config {

  makeFeature(fn) {
    const fc = FEATURE_CLASS[fn]
    const fi = new fc()
    // TODO: errors etc
    return fi
  }

  // False for a feature added at runtime via options.extend (station's
  // adopt path) - the constructor uses this to skip makeFeature for names
  // no generated class backs.
  hasFeature(fn) {
    return null != FEATURE_CLASS[fn]
  }


  main = {
    name: 'BluefinShieldconex',
        slug: "bluefin-shieldconex",
    version: "0.1.1",
    target: "js",

  }


  feature = {
     audit:     {
      "options": {
        "active": false,
        "actor": "anonymous",
        "max": 1000
      },
      "transport": "none"
    },
 clienttrack:     {
      "options": {
        "active": false,
        "clientVersion": "0.0.1"
      },
      "transport": "none"
    },
 idempotency:     {
      "options": {
        "active": false,
        "header": "Idempotency-Key",
        "methods": [
          "POST",
          "PUT",
          "PATCH",
          "DELETE"
        ],
        "ops": [
          "create",
          "update",
          "remove"
        ]
      },
      "transport": "none"
    },
 log:     {
      "options": {
        "active": true
      },
      "transport": "none"
    },
 metrics:     {
      "options": {
        "active": false
      },
      "transport": "none"
    },
 paging:     {
      "options": {
        "active": false,
        "afterVar": "after",
        "cursorParam": "cursor",
        "firstVar": "first",
        "limitParam": "limit",
        "pageParam": "page",
        "startPage": 1
      },
      "transport": "none"
    },
 ratelimit:     {
      "options": {
        "active": false,
        "burst": 5,
        "rate": 5
      },
      "transport": "wrap"
    },
 retry:     {
      "options": {
        "active": false,
        "factor": 2,
        "maxDelay": 2000,
        "minDelay": 50,
        "retries": 2,
        "statuses": [
          408,
          425,
          429,
          500,
          502,
          503,
          504
        ]
      },
      "transport": "wrap"
    },
 telemetry:     {
      "options": {
        "active": false
      },
      "transport": "none"
    },
 test:     {
      "options": {
        "active": false
      },
      "transport": "base"
    },
 timeout:     {
      "options": {
        "active": false,
        "ms": 30000
      },
      "transport": "wrap"
    },

  }


  options = {
    base: "https://secure-cert.shieldconex.com/api",

    auth: {
      prefix: 'Basic',
    },

    headers: {
      "content-type": "application/json"
    },

    entity: {
      
      detokenize: {
      },

      tokenize: {
      },

      tokenize_batch: {
      },

      tokenize_read: {
      },

      validate: {
      },

    }
  }


  entity = {
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
              "segments": [
                {
                  "lit": "tokenization"
                },
                {
                  "lit": "batch"
                },
                {
                  "lit": "detokenize"
                }
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "parts": [
                "tokenization",
                "batch",
                "detokenize"
              ]
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/tokenization/detokenize",
              "segments": [
                {
                  "lit": "tokenization"
                },
                {
                  "lit": "detokenize"
                }
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "parts": [
                "tokenization",
                "detokenize"
              ]
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
              "segments": [
                {
                  "lit": "healthcheck"
                },
                {
                  "lit": "detokenize"
                }
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
                "res": "`body.values`"
              },
              "parts": [
                "healthcheck",
                "detokenize"
              ]
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
              "segments": [
                {
                  "lit": "tokenization"
                },
                {
                  "lit": "batch"
                },
                {
                  "lit": "tokenize"
                }
              ],
              "select": {
                "exist": [
                  "omit"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "parts": [
                "tokenization",
                "batch",
                "tokenize"
              ]
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
              "segments": [
                {
                  "lit": "tokenization"
                },
                {
                  "lit": "tokenize"
                }
              ],
              "select": {
                "exist": [
                  "omit"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "parts": [
                "tokenization",
                "tokenize"
              ]
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/tokenization/delete",
              "segments": [
                {
                  "lit": "tokenization"
                },
                {
                  "lit": "delete"
                }
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "parts": [
                "tokenization",
                "delete"
              ]
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
              "segments": [
                {
                  "lit": "healthcheck"
                },
                {
                  "lit": "tokenize"
                }
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
                "res": "`body.values`"
              },
              "parts": [
                "healthcheck",
                "tokenize"
              ]
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
              "segments": [
                {
                  "lit": "tokenization"
                },
                {
                  "lit": "batch"
                },
                {
                  "lit": "delete"
                }
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "parts": [
                "tokenization",
                "batch",
                "delete"
              ]
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/tokenization/batch/read",
              "segments": [
                {
                  "lit": "tokenization"
                },
                {
                  "lit": "batch"
                },
                {
                  "lit": "read"
                }
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "parts": [
                "tokenization",
                "batch",
                "read"
              ]
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
              "segments": [
                {
                  "lit": "tokenization"
                },
                {
                  "lit": "read"
                }
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "parts": [
                "tokenization",
                "read"
              ]
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
              "segments": [
                {
                  "lit": "partner"
                },
                {
                  "lit": "validate"
                }
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "parts": [
                "partner",
                "validate"
              ]
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/template/validate",
              "segments": [
                {
                  "lit": "template"
                },
                {
                  "lit": "validate"
                }
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "parts": [
                "template",
                "validate"
              ]
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


const config = new Config()

module.exports = {
  config,
  FEATURE_PLUGINS,
}

