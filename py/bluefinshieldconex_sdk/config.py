# BluefinShieldconex SDK configuration


# The sekreto plugin DEFINITIONS the model selected per feature, imported
# above by name from the modules the catalogue's active `plugin.def`
# entries declare. Handed to each feature (secrets builds its Sekreto
# with them): a provider kind not listed here is unknown to that SDK.
FEATURE_PLUGINS = {
}


_shared_config = None


def shared_config():
    """Return the process-wide config, built once on first use.

    The SDK reads the config on every request and never writes to it, so one
    instance is shared by every client rather than rebuilt per client.

    The returned dict is shared: treat it as read-only. Callers that need to
    mutate should use make_config, which always returns a fresh copy.
    """
    global _shared_config
    if _shared_config is None:
        _shared_config = make_config()
    return _shared_config


def make_config():
    """Build a fresh, fully materialised config dict.

    Every call rebuilds the whole structure, so prefer shared_config unless
    you need a private copy you intend to mutate.
    """
    return {
        "main": {
            "name": "BluefinShieldconex",
            "slug": "bluefin-shieldconex",
            "version": "0.1.1",
            "target": "py",
        },
        "feature": {
            "audit": {
        "options": {
          "active": False,
          "actor": "anonymous",
          "max": 1000,
        },
        "transport": "none",
      },
            "clienttrack": {
        "options": {
          "active": False,
          "clientVersion": "0.0.1",
        },
        "transport": "none",
      },
            "idempotency": {
        "options": {
          "active": False,
          "header": "Idempotency-Key",
          "methods": [
            "POST",
            "PUT",
            "PATCH",
            "DELETE",
          ],
          "ops": [
            "create",
            "update",
            "remove",
          ],
        },
        "transport": "none",
      },
            "log": {
        "options": {
          "active": True,
        },
        "transport": "none",
      },
            "metrics": {
        "options": {
          "active": False,
        },
        "transport": "none",
      },
            "paging": {
        "options": {
          "active": False,
          "afterVar": "after",
          "cursorParam": "cursor",
          "firstVar": "first",
          "limitParam": "limit",
          "pageParam": "page",
          "startPage": 1,
        },
        "transport": "none",
      },
            "ratelimit": {
        "options": {
          "active": False,
          "burst": 5,
          "rate": 5,
        },
        "transport": "wrap",
      },
            "retry": {
        "options": {
          "active": False,
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
            504,
          ],
        },
        "transport": "wrap",
      },
            "telemetry": {
        "options": {
          "active": False,
        },
        "transport": "none",
      },
            "test": {
        "options": {
          "active": False,
        },
        "transport": "base",
      },
            "timeout": {
        "options": {
          "active": False,
          "ms": 30000,
        },
        "transport": "wrap",
      },
        },
        "options": {
            "base": "https://secure-cert.shieldconex.com/api",
            "auth": {
                "prefix": "Basic",
            },
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "detokenize": {},
                "tokenize": {},
                "tokenize_batch": {},
                "tokenize_read": {},
                "validate": {},
            },
        },
        "entity": {
      "detokenize": {
        "fields": [
          {
            "name": "batches",
            "op": {
              "create": {
                "req": True,
                "type": "`$ARRAY`",
              },
            },
            "type": "`$ARRAY`",
          },
          {
            "name": "bfid",
            "op": {
              "create": {
                "req": True,
                "type": "`$STRING`",
              },
            },
            "short": "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
            "type": "`$STRING`",
          },
          {
            "name": "messageId",
            "short": "Message Id",
            "type": "`$STRING`",
          },
          {
            "name": "name",
            "short": "Field Name.",
            "type": "`$STRING`",
          },
          {
            "name": "reference",
            "short": "Request Reference.",
            "type": "`$STRING`",
          },
          {
            "name": "value",
            "short": "Field Value.",
            "type": "`$STRING`",
          },
          {
            "name": "values",
            "op": {
              "create": {
                "req": True,
                "type": "`$ARRAY`",
              },
            },
            "type": "`$ARRAY`",
          },
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
                    "lit": "tokenization",
                  },
                  {
                    "lit": "batch",
                  },
                  {
                    "lit": "detokenize",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "tokenization",
                  "batch",
                  "detokenize",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/tokenization/detokenize",
                "segments": [
                  {
                    "lit": "tokenization",
                  },
                  {
                    "lit": "detokenize",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "tokenization",
                  "detokenize",
                ],
              },
            ],
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
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                    {
                      "kind": "query",
                      "name": "field_name",
                      "orig": "field_name",
                      "type": "`$STRING`",
                    },
                    {
                      "kind": "query",
                      "name": "field_value",
                      "orig": "field_value",
                      "type": "`$STRING`",
                    },
                    {
                      "kind": "query",
                      "name": "reference",
                      "orig": "reference",
                      "type": "`$STRING`",
                    },
                  ],
                },
                "kind": "http",
                "method": "GET",
                "orig": "/healthcheck/detokenize",
                "segments": [
                  {
                    "lit": "healthcheck",
                  },
                  {
                    "lit": "detokenize",
                  },
                ],
                "select": {
                  "exist": [
                    "bfid",
                    "field_name",
                    "field_value",
                    "reference",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.values`",
                },
                "parts": [
                  "healthcheck",
                  "detokenize",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "tokenize": {
        "fields": [
          {
            "name": "batches",
            "op": {
              "create": {
                "req": True,
                "type": "`$ARRAY`",
              },
            },
            "type": "`$ARRAY`",
          },
          {
            "name": "bfid",
            "op": {
              "create": {
                "req": True,
                "type": "`$STRING`",
              },
            },
            "short": "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
            "type": "`$STRING`",
          },
          {
            "name": "messageId",
            "short": "Message Id",
            "type": "`$STRING`",
          },
          {
            "name": "name",
            "short": "Field Name.",
            "type": "`$STRING`",
          },
          {
            "name": "reference",
            "short": "Request Reference.",
            "type": "`$STRING`",
          },
          {
            "name": "templateRef",
            "req": True,
            "short": "Template Reference",
            "type": "`$STRING`",
          },
          {
            "name": "value",
            "short": "Field Value.",
            "type": "`$STRING`",
          },
          {
            "name": "values",
            "op": {
              "create": {
                "req": True,
                "type": "`$ARRAY`",
              },
            },
            "type": "`$ARRAY`",
          },
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
                      "type": "`$NUMBER`",
                    },
                  ],
                },
                "kind": "http",
                "method": "POST",
                "orig": "/tokenization/batch/tokenize",
                "segments": [
                  {
                    "lit": "tokenization",
                  },
                  {
                    "lit": "batch",
                  },
                  {
                    "lit": "tokenize",
                  },
                ],
                "select": {
                  "exist": [
                    "omit",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "tokenization",
                  "batch",
                  "tokenize",
                ],
              },
              {
                "args": {
                  "query": [
                    {
                      "kind": "query",
                      "name": "omit",
                      "orig": "omit",
                      "type": "`$NUMBER`",
                    },
                  ],
                },
                "kind": "http",
                "method": "POST",
                "orig": "/tokenization/tokenize",
                "segments": [
                  {
                    "lit": "tokenization",
                  },
                  {
                    "lit": "tokenize",
                  },
                ],
                "select": {
                  "exist": [
                    "omit",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "tokenization",
                  "tokenize",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/tokenization/delete",
                "segments": [
                  {
                    "lit": "tokenization",
                  },
                  {
                    "lit": "delete",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "tokenization",
                  "delete",
                ],
              },
            ],
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
                      "type": "`$STRING`",
                    },
                    {
                      "kind": "query",
                      "name": "field_value",
                      "orig": "field_value",
                      "type": "`$STRING`",
                    },
                    {
                      "kind": "query",
                      "name": "reference",
                      "orig": "reference",
                      "type": "`$STRING`",
                    },
                    {
                      "kind": "query",
                      "name": "template_ref",
                      "orig": "template_ref",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "kind": "http",
                "method": "GET",
                "orig": "/healthcheck/tokenize",
                "segments": [
                  {
                    "lit": "healthcheck",
                  },
                  {
                    "lit": "tokenize",
                  },
                ],
                "select": {
                  "exist": [
                    "field_name",
                    "field_value",
                    "reference",
                    "template_ref",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.values`",
                },
                "parts": [
                  "healthcheck",
                  "tokenize",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "tokenize_batch": {
        "fields": [
          {
            "name": "batches",
            "op": {
              "create": {
                "req": True,
                "type": "`$ARRAY`",
              },
            },
            "type": "`$ARRAY`",
          },
          {
            "name": "messageId",
            "short": "Message Id",
            "type": "`$STRING`",
          },
          {
            "name": "reference",
            "short": "Request Reference.",
            "type": "`$STRING`",
          },
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
                    "lit": "tokenization",
                  },
                  {
                    "lit": "batch",
                  },
                  {
                    "lit": "delete",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "tokenization",
                  "batch",
                  "delete",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/tokenization/batch/read",
                "segments": [
                  {
                    "lit": "tokenization",
                  },
                  {
                    "lit": "batch",
                  },
                  {
                    "lit": "read",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "tokenization",
                  "batch",
                  "read",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "tokenize_read": {
        "fields": [
          {
            "name": "bfid",
            "op": {
              "create": {
                "req": True,
                "type": "`$STRING`",
              },
            },
            "short": "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
            "type": "`$STRING`",
          },
          {
            "name": "messageId",
            "short": "Message Id",
            "type": "`$STRING`",
          },
          {
            "name": "reference",
            "short": "Request Reference.",
            "type": "`$STRING`",
          },
          {
            "name": "state",
            "short": "Tokenized State Data (if available)",
            "type": "`$OBJECT`",
          },
          {
            "name": "values",
            "type": "`$ARRAY`",
          },
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
                    "lit": "tokenization",
                  },
                  {
                    "lit": "read",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "tokenization",
                  "read",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "validate": {
        "fields": [
          {
            "name": "messageId",
            "short": "Message Id",
            "type": "`$STRING`",
          },
          {
            "name": "reference",
            "short": "Request Reference.",
            "type": "`$STRING`",
          },
          {
            "name": "templateRef",
            "req": True,
            "short": "Template Reference.",
            "type": "`$STRING`",
          },
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
                    "lit": "partner",
                  },
                  {
                    "lit": "validate",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "partner",
                  "validate",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/template/validate",
                "segments": [
                  {
                    "lit": "template",
                  },
                  {
                    "lit": "validate",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "template",
                  "validate",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
