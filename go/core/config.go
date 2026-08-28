package core

import (
	"sync"
)

// MakeConfig builds a fresh, fully materialised config map. Every call
// rebuilds the whole structure, so prefer SharedConfig unless you need a
// private copy you intend to mutate.
func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "BluefinShieldconex",
			"slug": "bluefin-shieldconex",
			"version": "0.1.1",
			"target": "go",
		},
		"feature": map[string]any{
			"audit": map[string]any{
				"options": map[string]any{
					"active": false,
					"actor": "anonymous",
					"max": 1000,
				},
				"transport": "none",
			},
			"clienttrack": map[string]any{
				"options": map[string]any{
					"active": false,
					"clientVersion": "0.0.1",
				},
				"transport": "none",
			},
			"idempotency": map[string]any{
				"options": map[string]any{
					"active": false,
					"header": "Idempotency-Key",
					"methods": []any{
						"POST",
						"PUT",
						"PATCH",
						"DELETE",
					},
					"ops": []any{
						"create",
						"update",
						"remove",
					},
				},
				"transport": "none",
			},
			"log": map[string]any{
				"options": map[string]any{
					"active": true,
				},
				"transport": "none",
			},
			"metrics": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"transport": "none",
			},
			"paging": map[string]any{
				"options": map[string]any{
					"active": false,
					"afterVar": "after",
					"cursorParam": "cursor",
					"firstVar": "first",
					"limitParam": "limit",
					"pageParam": "page",
					"startPage": 1,
				},
				"transport": "none",
			},
			"ratelimit": map[string]any{
				"options": map[string]any{
					"active": false,
					"burst": 5,
					"rate": 5,
				},
				"transport": "wrap",
			},
			"retry": map[string]any{
				"options": map[string]any{
					"active": false,
					"factor": 2,
					"maxDelay": 2000,
					"minDelay": 50,
					"retries": 2,
					"statuses": []any{
						408,
						425,
						429,
						500,
						502,
						503,
						504,
					},
				},
				"transport": "wrap",
			},
			"telemetry": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"transport": "none",
			},
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"transport": "base",
			},
			"timeout": map[string]any{
				"options": map[string]any{
					"active": false,
					"ms": 30000,
				},
				"transport": "wrap",
			},
		},
		"options": map[string]any{
			"base": "https://secure-cert.shieldconex.com/api",
			"auth": map[string]any{
				"prefix": "Basic",
			},
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"detokenize": map[string]any{},
				"tokenize": map[string]any{},
				"tokenize_batch": map[string]any{},
				"tokenize_read": map[string]any{},
				"validate": map[string]any{},
			},
		},
		"entity": map[string]any{
			"detokenize": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "batches",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "bfid",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"short": "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "messageId",
						"short": "Message Id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"short": "Field Name.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "reference",
						"short": "Request Reference.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "value",
						"short": "Field Value.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "values",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"type": "`$ARRAY`",
					},
				},
				"name": "detokenize",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/tokenization/batch/detokenize",
								"parts": []any{
									"tokenization",
									"batch",
									"detokenize",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/tokenization/detokenize",
								"parts": []any{
									"tokenization",
									"detokenize",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "bfid",
											"orig": "bfid",
											"reqd": true,
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "field_name",
											"orig": "field_name",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "field_value",
											"orig": "field_value",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "reference",
											"orig": "reference",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/healthcheck/detokenize",
								"parts": []any{
									"healthcheck",
									"detokenize",
								},
								"select": map[string]any{
									"exist": []any{
										"bfid",
										"field_name",
										"field_value",
										"reference",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.values`",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"tokenize": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "batches",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "bfid",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"short": "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "messageId",
						"short": "Message Id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"short": "Field Name.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "reference",
						"short": "Request Reference.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "templateRef",
						"req": true,
						"short": "Template Reference",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "value",
						"short": "Field Value.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "values",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"type": "`$ARRAY`",
					},
				},
				"name": "tokenize",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "omit",
											"orig": "omit",
											"type": "`$NUMBER`",
										},
									},
								},
								"kind": "http",
								"method": "POST",
								"orig": "/tokenization/batch/tokenize",
								"parts": []any{
									"tokenization",
									"batch",
									"tokenize",
								},
								"select": map[string]any{
									"exist": []any{
										"omit",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "omit",
											"orig": "omit",
											"type": "`$NUMBER`",
										},
									},
								},
								"kind": "http",
								"method": "POST",
								"orig": "/tokenization/tokenize",
								"parts": []any{
									"tokenization",
									"tokenize",
								},
								"select": map[string]any{
									"exist": []any{
										"omit",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/tokenization/delete",
								"parts": []any{
									"tokenization",
									"delete",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "field_name",
											"orig": "field_name",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "field_value",
											"orig": "field_value",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "reference",
											"orig": "reference",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "template_ref",
											"orig": "template_ref",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/healthcheck/tokenize",
								"parts": []any{
									"healthcheck",
									"tokenize",
								},
								"select": map[string]any{
									"exist": []any{
										"field_name",
										"field_value",
										"reference",
										"template_ref",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.values`",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"tokenize_batch": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "batches",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "messageId",
						"short": "Message Id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "reference",
						"short": "Request Reference.",
						"type": "`$STRING`",
					},
				},
				"name": "tokenize_batch",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/tokenization/batch/delete",
								"parts": []any{
									"tokenization",
									"batch",
									"delete",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/tokenization/batch/read",
								"parts": []any{
									"tokenization",
									"batch",
									"read",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"tokenize_read": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "bfid",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"short": "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "messageId",
						"short": "Message Id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "reference",
						"short": "Request Reference.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "state",
						"short": "Tokenized State Data (if available)",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "values",
						"type": "`$ARRAY`",
					},
				},
				"name": "tokenize_read",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/tokenization/read",
								"parts": []any{
									"tokenization",
									"read",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"validate": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "messageId",
						"short": "Message Id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "reference",
						"short": "Request Reference.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "templateRef",
						"req": true,
						"short": "Template Reference.",
						"type": "`$STRING`",
					},
				},
				"name": "validate",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/partner/validate",
								"parts": []any{
									"partner",
									"validate",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/template/validate",
								"parts": []any{
									"template",
									"validate",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
		},
	}
}

var (
	sharedConfigOnce sync.Once
	sharedConfigVal  map[string]any
)

// SharedConfig returns the process-wide config, built once on first use.
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client.
//
// The returned map is shared: treat it as read-only. Callers that need to
// mutate should use MakeConfig, which always returns a fresh copy.
func SharedConfig() map[string]any {
	sharedConfigOnce.Do(func() {
		sharedConfigVal = MakeConfig()
	})
	return sharedConfigVal
}

func makeFeature(name string) Feature {
	switch name {
	case "audit":
		if NewAuditFeatureFunc != nil {
			return NewAuditFeatureFunc()
		}
	case "clienttrack":
		if NewClienttrackFeatureFunc != nil {
			return NewClienttrackFeatureFunc()
		}
	case "idempotency":
		if NewIdempotencyFeatureFunc != nil {
			return NewIdempotencyFeatureFunc()
		}
	case "log":
		if NewLogFeatureFunc != nil {
			return NewLogFeatureFunc()
		}
	case "metrics":
		if NewMetricsFeatureFunc != nil {
			return NewMetricsFeatureFunc()
		}
	case "paging":
		if NewPagingFeatureFunc != nil {
			return NewPagingFeatureFunc()
		}
	case "ratelimit":
		if NewRatelimitFeatureFunc != nil {
			return NewRatelimitFeatureFunc()
		}
	case "retry":
		if NewRetryFeatureFunc != nil {
			return NewRetryFeatureFunc()
		}
	case "telemetry":
		if NewTelemetryFeatureFunc != nil {
			return NewTelemetryFeatureFunc()
		}
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	case "timeout":
		if NewTimeoutFeatureFunc != nil {
			return NewTimeoutFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
