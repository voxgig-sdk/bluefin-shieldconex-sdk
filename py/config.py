# BluefinShieldconex SDK configuration


def make_config():
    return {
        "main": {
            "name": "BluefinShieldconex",
        },
        "feature": {
            "test": {
        "options": {
          "active": False,
        },
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
            "active": True,
            "name": "batch",
            "op": {
              "create": {
                "req": True,
                "type": "`$ARRAY`",
              },
            },
            "req": False,
            "type": "`$ARRAY`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "bfid",
            "op": {
              "create": {
                "req": True,
                "type": "`$STRING`",
              },
            },
            "req": False,
            "type": "`$STRING`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "message_id",
            "req": False,
            "type": "`$STRING`",
            "index$": 2,
          },
          {
            "active": True,
            "name": "name",
            "req": False,
            "type": "`$STRING`",
            "index$": 3,
          },
          {
            "active": True,
            "name": "reference",
            "req": False,
            "type": "`$STRING`",
            "index$": 4,
          },
          {
            "active": True,
            "name": "value",
            "op": {
              "create": {
                "req": True,
                "type": "`$ARRAY`",
              },
            },
            "req": False,
            "type": "`$ARRAY`",
            "index$": 5,
          },
        ],
        "name": "detokenize",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/tokenization/batch/detokenize",
                "parts": [
                  "tokenization",
                  "batch",
                  "detokenize",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/tokenization/detokenize",
                "parts": [
                  "tokenization",
                  "detokenize",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
            ],
            "key$": "create",
          },
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "bfid",
                      "orig": "bfid",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "field_name",
                      "orig": "field_name",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "field_value",
                      "orig": "field_value",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "reference",
                      "orig": "reference",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/healthcheck/detokenize",
                "parts": [
                  "healthcheck",
                  "detokenize",
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
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "tokenize": {
        "fields": [
          {
            "active": True,
            "name": "batch",
            "op": {
              "create": {
                "req": True,
                "type": "`$ARRAY`",
              },
            },
            "req": False,
            "type": "`$ARRAY`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "bfid",
            "op": {
              "create": {
                "req": True,
                "type": "`$STRING`",
              },
            },
            "req": False,
            "type": "`$STRING`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "message_id",
            "req": False,
            "type": "`$STRING`",
            "index$": 2,
          },
          {
            "active": True,
            "name": "name",
            "req": False,
            "type": "`$STRING`",
            "index$": 3,
          },
          {
            "active": True,
            "name": "reference",
            "req": False,
            "type": "`$STRING`",
            "index$": 4,
          },
          {
            "active": True,
            "name": "template_ref",
            "req": True,
            "type": "`$STRING`",
            "index$": 5,
          },
          {
            "active": True,
            "name": "value",
            "op": {
              "create": {
                "req": True,
                "type": "`$ARRAY`",
              },
            },
            "req": False,
            "type": "`$ARRAY`",
            "index$": 6,
          },
        ],
        "name": "tokenize",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "omit",
                      "orig": "omit",
                      "reqd": False,
                      "type": "`$NUMBER`",
                    },
                  ],
                },
                "method": "POST",
                "orig": "/tokenization/batch/tokenize",
                "parts": [
                  "tokenization",
                  "batch",
                  "tokenize",
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
                "index$": 0,
              },
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "omit",
                      "orig": "omit",
                      "reqd": False,
                      "type": "`$NUMBER`",
                    },
                  ],
                },
                "method": "POST",
                "orig": "/tokenization/tokenize",
                "parts": [
                  "tokenization",
                  "tokenize",
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
                "index$": 1,
              },
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/tokenization/delete",
                "parts": [
                  "tokenization",
                  "delete",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 2,
              },
            ],
            "key$": "create",
          },
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "field_name",
                      "orig": "field_name",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "field_value",
                      "orig": "field_value",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "reference",
                      "orig": "reference",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "template_ref",
                      "orig": "template_ref",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/healthcheck/tokenize",
                "parts": [
                  "healthcheck",
                  "tokenize",
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
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "tokenize_batch": {
        "fields": [
          {
            "active": True,
            "name": "batch",
            "op": {
              "create": {
                "req": True,
                "type": "`$ARRAY`",
              },
            },
            "req": False,
            "type": "`$ARRAY`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "message_id",
            "req": False,
            "type": "`$STRING`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "reference",
            "req": False,
            "type": "`$STRING`",
            "index$": 2,
          },
        ],
        "name": "tokenize_batch",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/tokenization/batch/delete",
                "parts": [
                  "tokenization",
                  "batch",
                  "delete",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/tokenization/batch/read",
                "parts": [
                  "tokenization",
                  "batch",
                  "read",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
            ],
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "tokenize_read": {
        "fields": [
          {
            "active": True,
            "name": "bfid",
            "op": {
              "create": {
                "req": True,
                "type": "`$STRING`",
              },
            },
            "req": False,
            "type": "`$STRING`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "message_id",
            "req": False,
            "type": "`$STRING`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "reference",
            "req": False,
            "type": "`$STRING`",
            "index$": 2,
          },
          {
            "active": True,
            "name": "state",
            "req": False,
            "type": "`$OBJECT`",
            "index$": 3,
          },
          {
            "active": True,
            "name": "value",
            "req": False,
            "type": "`$ARRAY`",
            "index$": 4,
          },
        ],
        "name": "tokenize_read",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/tokenization/read",
                "parts": [
                  "tokenization",
                  "read",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "validate": {
        "fields": [
          {
            "active": True,
            "name": "message_id",
            "req": False,
            "type": "`$STRING`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "reference",
            "req": False,
            "type": "`$STRING`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "template_ref",
            "req": True,
            "type": "`$STRING`",
            "index$": 2,
          },
        ],
        "name": "validate",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/partner/validate",
                "parts": [
                  "partner",
                  "validate",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/template/validate",
                "parts": [
                  "template",
                  "validate",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
            ],
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
