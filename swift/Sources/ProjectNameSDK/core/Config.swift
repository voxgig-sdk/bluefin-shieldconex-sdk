// BluefinShieldconex SDK - generated model configuration and feature
// factory. GENERATED from the API model - do not edit by hand.

import Foundation

public enum SdkConfig {
  public static func makeConfig() -> VMap {
    let json = #"""
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
    "headers": {
      "content-type": "application/json"
    },
    "entity": {
      "detokenize": {},
      "tokenize": {},
      "tokenize_batch": {},
      "tokenize_read": {},
      "validate": {}
    },
    "auth": {
      "prefix": "Basic"
    }
  },
  "entity": {
    "detokenize": {
      "fields": [
        {
          "active": true,
          "name": "batch",
          "op": {
            "create": {
              "req": true,
              "type": "`$ARRAY`"
            }
          },
          "req": false,
          "type": "`$ARRAY`",
          "index$": 0
        },
        {
          "active": true,
          "name": "bfid",
          "op": {
            "create": {
              "req": true,
              "type": "`$STRING`"
            }
          },
          "req": false,
          "type": "`$STRING`",
          "index$": 1
        },
        {
          "active": true,
          "name": "message_id",
          "req": false,
          "type": "`$STRING`",
          "index$": 2
        },
        {
          "active": true,
          "name": "name",
          "req": false,
          "type": "`$STRING`",
          "index$": 3
        },
        {
          "active": true,
          "name": "reference",
          "req": false,
          "type": "`$STRING`",
          "index$": 4
        },
        {
          "active": true,
          "name": "value",
          "op": {
            "create": {
              "req": true,
              "type": "`$ARRAY`"
            }
          },
          "req": false,
          "type": "`$ARRAY`",
          "index$": 5
        }
      ],
      "name": "detokenize",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "active": true,
              "args": {},
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
              },
              "index$": 0
            },
            {
              "active": true,
              "args": {},
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
              },
              "index$": 1
            }
          ],
          "key$": "create"
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "active": true,
              "args": {
                "query": [
                  {
                    "active": true,
                    "kind": "query",
                    "name": "bfid",
                    "orig": "bfid",
                    "reqd": true,
                    "type": "`$STRING`"
                  },
                  {
                    "active": true,
                    "kind": "query",
                    "name": "field_name",
                    "orig": "field_name",
                    "reqd": false,
                    "type": "`$STRING`"
                  },
                  {
                    "active": true,
                    "kind": "query",
                    "name": "field_value",
                    "orig": "field_value",
                    "reqd": false,
                    "type": "`$STRING`"
                  },
                  {
                    "active": true,
                    "kind": "query",
                    "name": "reference",
                    "orig": "reference",
                    "reqd": false,
                    "type": "`$STRING`"
                  }
                ]
              },
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
              },
              "index$": 0
            }
          ],
          "key$": "list"
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "tokenize": {
      "fields": [
        {
          "active": true,
          "name": "batch",
          "op": {
            "create": {
              "req": true,
              "type": "`$ARRAY`"
            }
          },
          "req": false,
          "type": "`$ARRAY`",
          "index$": 0
        },
        {
          "active": true,
          "name": "bfid",
          "op": {
            "create": {
              "req": true,
              "type": "`$STRING`"
            }
          },
          "req": false,
          "type": "`$STRING`",
          "index$": 1
        },
        {
          "active": true,
          "name": "message_id",
          "req": false,
          "type": "`$STRING`",
          "index$": 2
        },
        {
          "active": true,
          "name": "name",
          "req": false,
          "type": "`$STRING`",
          "index$": 3
        },
        {
          "active": true,
          "name": "reference",
          "req": false,
          "type": "`$STRING`",
          "index$": 4
        },
        {
          "active": true,
          "name": "template_ref",
          "req": true,
          "type": "`$STRING`",
          "index$": 5
        },
        {
          "active": true,
          "name": "value",
          "op": {
            "create": {
              "req": true,
              "type": "`$ARRAY`"
            }
          },
          "req": false,
          "type": "`$ARRAY`",
          "index$": 6
        }
      ],
      "name": "tokenize",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "active": true,
              "args": {
                "query": [
                  {
                    "active": true,
                    "kind": "query",
                    "name": "omit",
                    "orig": "omit",
                    "reqd": false,
                    "type": "`$NUMBER`"
                  }
                ]
              },
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
              },
              "index$": 0
            },
            {
              "active": true,
              "args": {
                "query": [
                  {
                    "active": true,
                    "kind": "query",
                    "name": "omit",
                    "orig": "omit",
                    "reqd": false,
                    "type": "`$NUMBER`"
                  }
                ]
              },
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
              },
              "index$": 1
            },
            {
              "active": true,
              "args": {},
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
              },
              "index$": 2
            }
          ],
          "key$": "create"
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "active": true,
              "args": {
                "query": [
                  {
                    "active": true,
                    "kind": "query",
                    "name": "field_name",
                    "orig": "field_name",
                    "reqd": false,
                    "type": "`$STRING`"
                  },
                  {
                    "active": true,
                    "kind": "query",
                    "name": "field_value",
                    "orig": "field_value",
                    "reqd": false,
                    "type": "`$STRING`"
                  },
                  {
                    "active": true,
                    "kind": "query",
                    "name": "reference",
                    "orig": "reference",
                    "reqd": false,
                    "type": "`$STRING`"
                  },
                  {
                    "active": true,
                    "kind": "query",
                    "name": "template_ref",
                    "orig": "template_ref",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
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
              },
              "index$": 0
            }
          ],
          "key$": "list"
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "tokenize_batch": {
      "fields": [
        {
          "active": true,
          "name": "batch",
          "op": {
            "create": {
              "req": true,
              "type": "`$ARRAY`"
            }
          },
          "req": false,
          "type": "`$ARRAY`",
          "index$": 0
        },
        {
          "active": true,
          "name": "message_id",
          "req": false,
          "type": "`$STRING`",
          "index$": 1
        },
        {
          "active": true,
          "name": "reference",
          "req": false,
          "type": "`$STRING`",
          "index$": 2
        }
      ],
      "name": "tokenize_batch",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "active": true,
              "args": {},
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
              },
              "index$": 0
            },
            {
              "active": true,
              "args": {},
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
              },
              "index$": 1
            }
          ],
          "key$": "create"
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "tokenize_read": {
      "fields": [
        {
          "active": true,
          "name": "bfid",
          "op": {
            "create": {
              "req": true,
              "type": "`$STRING`"
            }
          },
          "req": false,
          "type": "`$STRING`",
          "index$": 0
        },
        {
          "active": true,
          "name": "message_id",
          "req": false,
          "type": "`$STRING`",
          "index$": 1
        },
        {
          "active": true,
          "name": "reference",
          "req": false,
          "type": "`$STRING`",
          "index$": 2
        },
        {
          "active": true,
          "name": "state",
          "req": false,
          "type": "`$OBJECT`",
          "index$": 3
        },
        {
          "active": true,
          "name": "value",
          "req": false,
          "type": "`$ARRAY`",
          "index$": 4
        }
      ],
      "name": "tokenize_read",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "active": true,
              "args": {},
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
              },
              "index$": 0
            }
          ],
          "key$": "create"
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "validate": {
      "fields": [
        {
          "active": true,
          "name": "message_id",
          "req": false,
          "type": "`$STRING`",
          "index$": 0
        },
        {
          "active": true,
          "name": "reference",
          "req": false,
          "type": "`$STRING`",
          "index$": 1
        },
        {
          "active": true,
          "name": "template_ref",
          "req": true,
          "type": "`$STRING`",
          "index$": 2
        }
      ],
      "name": "validate",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "active": true,
              "args": {},
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
              },
              "index$": 0
            },
            {
              "active": true,
              "args": {},
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
              },
              "index$": 1
            }
          ],
          "key$": "create"
        }
      },
      "relations": {
        "ancestors": []
      }
    }
  }
}
"""#
    return (try? JSON.parse(json))?.asMap ?? VMap()
  }

  public static func makeFeature(_ name: String) -> BaseFeature {
    switch name {
    case "test": return TestFeature()
    default: return BaseFeature()
    }
  }
}
