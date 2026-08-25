# BluefinShieldconex SDK configuration
#
# Returns the resolved SDK config as vendored-struct nodes (via
# BluefinShieldconex.Helpers.deep/1). Do not edit by hand.

defmodule BluefinShieldconex.Config do
  def make_config do
    BluefinShieldconex.Helpers.deep(%{
      "main" => %{
        "name" => "BluefinShieldconex",
        "slug" => "bluefin-shieldconex",
        "version" => "0.1.1",
        "target" => "elixir"
      },
      "feature" => %{
        "test" => %{
          "options" => %{
            "active" => false
          },
          "transport" => "base"
        },
      },
      "options" => %{
        "base" => "https://secure-cert.shieldconex.com/api",
        "auth" => %{
          "prefix" => "Basic"
        },
        "headers" => %{
          "content-type" => "application/json"
        },
        "entity" => %{
          "detokenize" => %{},
          "tokenize" => %{},
          "tokenize_batch" => %{},
          "tokenize_read" => %{},
          "validate" => %{}
        }
      },
      "entity" => %{
        "detokenize" => %{
          "fields" => [
            %{
              "name" => "batches",
              "op" => %{
                "create" => %{
                  "req" => true,
                  "type" => "`$ARRAY`"
                }
              },
              "type" => "`$ARRAY`"
            },
            %{
              "name" => "bfid",
              "op" => %{
                "create" => %{
                  "req" => true,
                  "type" => "`$STRING`"
                }
              },
              "short" => "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
              "type" => "`$STRING`"
            },
            %{
              "name" => "messageId",
              "short" => "Message Id",
              "type" => "`$STRING`"
            },
            %{
              "name" => "name",
              "short" => "Field Name.",
              "type" => "`$STRING`"
            },
            %{
              "name" => "reference",
              "short" => "Request Reference.",
              "type" => "`$STRING`"
            },
            %{
              "name" => "value",
              "short" => "Field Value.",
              "type" => "`$STRING`"
            },
            %{
              "name" => "values",
              "op" => %{
                "create" => %{
                  "req" => true,
                  "type" => "`$ARRAY`"
                }
              },
              "type" => "`$ARRAY`"
            }
          ],
          "name" => "detokenize",
          "op" => %{
            "create" => %{
              "input" => "data",
              "name" => "create",
              "points" => [
                %{
                  "args" => %{},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/detokenize",
                  "parts" => [
                    "tokenization",
                    "batch",
                    "detokenize"
                  ],
                  "select" => %{},
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  }
                },
                %{
                  "args" => %{},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/detokenize",
                  "parts" => [
                    "tokenization",
                    "detokenize"
                  ],
                  "select" => %{},
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  }
                }
              ]
            },
            "list" => %{
              "input" => "data",
              "name" => "list",
              "points" => [
                %{
                  "args" => %{
                    "query" => [
                      %{
                        "kind" => "query",
                        "name" => "bfid",
                        "orig" => "bfid",
                        "reqd" => true,
                        "type" => "`$STRING`"
                      },
                      %{
                        "kind" => "query",
                        "name" => "field_name",
                        "orig" => "field_name",
                        "type" => "`$STRING`"
                      },
                      %{
                        "kind" => "query",
                        "name" => "field_value",
                        "orig" => "field_value",
                        "type" => "`$STRING`"
                      },
                      %{
                        "kind" => "query",
                        "name" => "reference",
                        "orig" => "reference",
                        "type" => "`$STRING`"
                      }
                    ]
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/healthcheck/detokenize",
                  "parts" => [
                    "healthcheck",
                    "detokenize"
                  ],
                  "select" => %{
                    "exist" => [
                      "bfid",
                      "field_name",
                      "field_value",
                      "reference"
                    ]
                  },
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body.values`"
                  }
                }
              ]
            }
          },
          "relations" => %{
            "ancestors" => []
          }
        },
        "tokenize" => %{
          "fields" => [
            %{
              "name" => "batches",
              "op" => %{
                "create" => %{
                  "req" => true,
                  "type" => "`$ARRAY`"
                }
              },
              "type" => "`$ARRAY`"
            },
            %{
              "name" => "bfid",
              "op" => %{
                "create" => %{
                  "req" => true,
                  "type" => "`$STRING`"
                }
              },
              "short" => "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
              "type" => "`$STRING`"
            },
            %{
              "name" => "messageId",
              "short" => "Message Id",
              "type" => "`$STRING`"
            },
            %{
              "name" => "name",
              "short" => "Field Name.",
              "type" => "`$STRING`"
            },
            %{
              "name" => "reference",
              "short" => "Request Reference.",
              "type" => "`$STRING`"
            },
            %{
              "name" => "templateRef",
              "req" => true,
              "short" => "Template Reference",
              "type" => "`$STRING`"
            },
            %{
              "name" => "value",
              "short" => "Field Value.",
              "type" => "`$STRING`"
            },
            %{
              "name" => "values",
              "op" => %{
                "create" => %{
                  "req" => true,
                  "type" => "`$ARRAY`"
                }
              },
              "type" => "`$ARRAY`"
            }
          ],
          "name" => "tokenize",
          "op" => %{
            "create" => %{
              "input" => "data",
              "name" => "create",
              "points" => [
                %{
                  "args" => %{
                    "query" => [
                      %{
                        "kind" => "query",
                        "name" => "omit",
                        "orig" => "omit",
                        "type" => "`$NUMBER`"
                      }
                    ]
                  },
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/tokenize",
                  "parts" => [
                    "tokenization",
                    "batch",
                    "tokenize"
                  ],
                  "select" => %{
                    "exist" => [
                      "omit"
                    ]
                  },
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  }
                },
                %{
                  "args" => %{
                    "query" => [
                      %{
                        "kind" => "query",
                        "name" => "omit",
                        "orig" => "omit",
                        "type" => "`$NUMBER`"
                      }
                    ]
                  },
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/tokenize",
                  "parts" => [
                    "tokenization",
                    "tokenize"
                  ],
                  "select" => %{
                    "exist" => [
                      "omit"
                    ]
                  },
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  }
                },
                %{
                  "args" => %{},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/delete",
                  "parts" => [
                    "tokenization",
                    "delete"
                  ],
                  "select" => %{},
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  }
                }
              ]
            },
            "list" => %{
              "input" => "data",
              "name" => "list",
              "points" => [
                %{
                  "args" => %{
                    "query" => [
                      %{
                        "kind" => "query",
                        "name" => "field_name",
                        "orig" => "field_name",
                        "type" => "`$STRING`"
                      },
                      %{
                        "kind" => "query",
                        "name" => "field_value",
                        "orig" => "field_value",
                        "type" => "`$STRING`"
                      },
                      %{
                        "kind" => "query",
                        "name" => "reference",
                        "orig" => "reference",
                        "type" => "`$STRING`"
                      },
                      %{
                        "kind" => "query",
                        "name" => "template_ref",
                        "orig" => "template_ref",
                        "reqd" => true,
                        "type" => "`$STRING`"
                      }
                    ]
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/healthcheck/tokenize",
                  "parts" => [
                    "healthcheck",
                    "tokenize"
                  ],
                  "select" => %{
                    "exist" => [
                      "field_name",
                      "field_value",
                      "reference",
                      "template_ref"
                    ]
                  },
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body.values`"
                  }
                }
              ]
            }
          },
          "relations" => %{
            "ancestors" => []
          }
        },
        "tokenize_batch" => %{
          "fields" => [
            %{
              "name" => "batches",
              "op" => %{
                "create" => %{
                  "req" => true,
                  "type" => "`$ARRAY`"
                }
              },
              "type" => "`$ARRAY`"
            },
            %{
              "name" => "messageId",
              "short" => "Message Id",
              "type" => "`$STRING`"
            },
            %{
              "name" => "reference",
              "short" => "Request Reference.",
              "type" => "`$STRING`"
            }
          ],
          "name" => "tokenize_batch",
          "op" => %{
            "create" => %{
              "input" => "data",
              "name" => "create",
              "points" => [
                %{
                  "args" => %{},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/delete",
                  "parts" => [
                    "tokenization",
                    "batch",
                    "delete"
                  ],
                  "select" => %{},
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  }
                },
                %{
                  "args" => %{},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/batch/read",
                  "parts" => [
                    "tokenization",
                    "batch",
                    "read"
                  ],
                  "select" => %{},
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  }
                }
              ]
            }
          },
          "relations" => %{
            "ancestors" => []
          }
        },
        "tokenize_read" => %{
          "fields" => [
            %{
              "name" => "bfid",
              "op" => %{
                "create" => %{
                  "req" => true,
                  "type" => "`$STRING`"
                }
              },
              "short" => "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
              "type" => "`$STRING`"
            },
            %{
              "name" => "messageId",
              "short" => "Message Id",
              "type" => "`$STRING`"
            },
            %{
              "name" => "reference",
              "short" => "Request Reference.",
              "type" => "`$STRING`"
            },
            %{
              "name" => "state",
              "short" => "Tokenized State Data (if available)",
              "type" => "`$OBJECT`"
            },
            %{
              "name" => "values",
              "type" => "`$ARRAY`"
            }
          ],
          "name" => "tokenize_read",
          "op" => %{
            "create" => %{
              "input" => "data",
              "name" => "create",
              "points" => [
                %{
                  "args" => %{},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tokenization/read",
                  "parts" => [
                    "tokenization",
                    "read"
                  ],
                  "select" => %{},
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  }
                }
              ]
            }
          },
          "relations" => %{
            "ancestors" => []
          }
        },
        "validate" => %{
          "fields" => [
            %{
              "name" => "messageId",
              "short" => "Message Id",
              "type" => "`$STRING`"
            },
            %{
              "name" => "reference",
              "short" => "Request Reference.",
              "type" => "`$STRING`"
            },
            %{
              "name" => "templateRef",
              "req" => true,
              "short" => "Template Reference.",
              "type" => "`$STRING`"
            }
          ],
          "name" => "validate",
          "op" => %{
            "create" => %{
              "input" => "data",
              "name" => "create",
              "points" => [
                %{
                  "args" => %{},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/partner/validate",
                  "parts" => [
                    "partner",
                    "validate"
                  ],
                  "select" => %{},
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  }
                },
                %{
                  "args" => %{},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/template/validate",
                  "parts" => [
                    "template",
                    "validate"
                  ],
                  "select" => %{},
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  }
                }
              ]
            }
          },
          "relations" => %{
            "ancestors" => []
          }
        }
      }
    })
  end

  # SHARED CONFIG (sdkgen rung L2). See the data branch for the rationale, and
  # for why the cached handle is validated on read.
  @shared_key {__MODULE__, :shared_config}

  # The process-wide config, built once on first use. The returned node is
  # SHARED: treat it as read-only. Callers that need to mutate should use
  # make_config, which always returns a fresh copy.
  def shared_config do
    cached = :persistent_term.get(@shared_key, nil)

    if cached != nil and usable?(cached) do
      cached
    else
      cfg = make_config()
      :persistent_term.put(@shared_key, cfg)
      cfg
    end
  end

  defp usable?(cfg) do
    Voxgig.Struct.getprop(cfg, "main")
    true
  rescue
    ArgumentError -> false
  end
end
