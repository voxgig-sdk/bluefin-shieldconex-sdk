package core

func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "BluefinShieldconex",
		},
		"feature": map[string]any{
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
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
						"active": true,
						"name": "batch",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"req": false,
						"type": "`$ARRAY`",
						"index$": 0,
					},
					map[string]any{
						"active": true,
						"name": "bfid",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"req": false,
						"type": "`$STRING`",
						"index$": 1,
					},
					map[string]any{
						"active": true,
						"name": "message_id",
						"req": false,
						"type": "`$STRING`",
						"index$": 2,
					},
					map[string]any{
						"active": true,
						"name": "name",
						"req": false,
						"type": "`$STRING`",
						"index$": 3,
					},
					map[string]any{
						"active": true,
						"name": "reference",
						"req": false,
						"type": "`$STRING`",
						"index$": 4,
					},
					map[string]any{
						"active": true,
						"name": "value",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"req": false,
						"type": "`$ARRAY`",
						"index$": 5,
					},
				},
				"name": "detokenize",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{},
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
								"index$": 0,
							},
							map[string]any{
								"active": true,
								"args": map[string]any{},
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
								"index$": 1,
							},
						},
						"key$": "create",
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "bfid",
											"orig": "bfid",
											"reqd": true,
											"type": "`$STRING`",
										},
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "field_name",
											"orig": "field_name",
											"reqd": false,
											"type": "`$STRING`",
										},
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "field_value",
											"orig": "field_value",
											"reqd": false,
											"type": "`$STRING`",
										},
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "reference",
											"orig": "reference",
											"reqd": false,
											"type": "`$STRING`",
										},
									},
								},
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
									"res": "`body`",
								},
								"index$": 0,
							},
						},
						"key$": "list",
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"tokenize": map[string]any{
				"fields": []any{
					map[string]any{
						"active": true,
						"name": "batch",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"req": false,
						"type": "`$ARRAY`",
						"index$": 0,
					},
					map[string]any{
						"active": true,
						"name": "bfid",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"req": false,
						"type": "`$STRING`",
						"index$": 1,
					},
					map[string]any{
						"active": true,
						"name": "message_id",
						"req": false,
						"type": "`$STRING`",
						"index$": 2,
					},
					map[string]any{
						"active": true,
						"name": "name",
						"req": false,
						"type": "`$STRING`",
						"index$": 3,
					},
					map[string]any{
						"active": true,
						"name": "reference",
						"req": false,
						"type": "`$STRING`",
						"index$": 4,
					},
					map[string]any{
						"active": true,
						"name": "template_ref",
						"req": true,
						"type": "`$STRING`",
						"index$": 5,
					},
					map[string]any{
						"active": true,
						"name": "value",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"req": false,
						"type": "`$ARRAY`",
						"index$": 6,
					},
				},
				"name": "tokenize",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "omit",
											"orig": "omit",
											"reqd": false,
											"type": "`$NUMBER`",
										},
									},
								},
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
								"index$": 0,
							},
							map[string]any{
								"active": true,
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "omit",
											"orig": "omit",
											"reqd": false,
											"type": "`$NUMBER`",
										},
									},
								},
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
								"index$": 1,
							},
							map[string]any{
								"active": true,
								"args": map[string]any{},
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
								"index$": 2,
							},
						},
						"key$": "create",
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "field_name",
											"orig": "field_name",
											"reqd": false,
											"type": "`$STRING`",
										},
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "field_value",
											"orig": "field_value",
											"reqd": false,
											"type": "`$STRING`",
										},
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "reference",
											"orig": "reference",
											"reqd": false,
											"type": "`$STRING`",
										},
										map[string]any{
											"active": true,
											"kind": "query",
											"name": "template_ref",
											"orig": "template_ref",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
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
									"res": "`body`",
								},
								"index$": 0,
							},
						},
						"key$": "list",
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"tokenize_batch": map[string]any{
				"fields": []any{
					map[string]any{
						"active": true,
						"name": "batch",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$ARRAY`",
							},
						},
						"req": false,
						"type": "`$ARRAY`",
						"index$": 0,
					},
					map[string]any{
						"active": true,
						"name": "message_id",
						"req": false,
						"type": "`$STRING`",
						"index$": 1,
					},
					map[string]any{
						"active": true,
						"name": "reference",
						"req": false,
						"type": "`$STRING`",
						"index$": 2,
					},
				},
				"name": "tokenize_batch",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{},
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
								"index$": 0,
							},
							map[string]any{
								"active": true,
								"args": map[string]any{},
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
								"index$": 1,
							},
						},
						"key$": "create",
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"tokenize_read": map[string]any{
				"fields": []any{
					map[string]any{
						"active": true,
						"name": "bfid",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"req": false,
						"type": "`$STRING`",
						"index$": 0,
					},
					map[string]any{
						"active": true,
						"name": "message_id",
						"req": false,
						"type": "`$STRING`",
						"index$": 1,
					},
					map[string]any{
						"active": true,
						"name": "reference",
						"req": false,
						"type": "`$STRING`",
						"index$": 2,
					},
					map[string]any{
						"active": true,
						"name": "state",
						"req": false,
						"type": "`$OBJECT`",
						"index$": 3,
					},
					map[string]any{
						"active": true,
						"name": "value",
						"req": false,
						"type": "`$ARRAY`",
						"index$": 4,
					},
				},
				"name": "tokenize_read",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{},
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
								"index$": 0,
							},
						},
						"key$": "create",
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"validate": map[string]any{
				"fields": []any{
					map[string]any{
						"active": true,
						"name": "message_id",
						"req": false,
						"type": "`$STRING`",
						"index$": 0,
					},
					map[string]any{
						"active": true,
						"name": "reference",
						"req": false,
						"type": "`$STRING`",
						"index$": 1,
					},
					map[string]any{
						"active": true,
						"name": "template_ref",
						"req": true,
						"type": "`$STRING`",
						"index$": 2,
					},
				},
				"name": "validate",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{},
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
								"index$": 0,
							},
							map[string]any{
								"active": true,
								"args": map[string]any{},
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
								"index$": 1,
							},
						},
						"key$": "create",
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
		},
	}
}

func makeFeature(name string) Feature {
	switch name {
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
