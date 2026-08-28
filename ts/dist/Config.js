"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.config = void 0;
const AuditFeature_1 = require("./feature/audit/AuditFeature");
const ClienttrackFeature_1 = require("./feature/clienttrack/ClienttrackFeature");
const IdempotencyFeature_1 = require("./feature/idempotency/IdempotencyFeature");
const LogFeature_1 = require("./feature/log/LogFeature");
const MetricsFeature_1 = require("./feature/metrics/MetricsFeature");
const PagingFeature_1 = require("./feature/paging/PagingFeature");
const RatelimitFeature_1 = require("./feature/ratelimit/RatelimitFeature");
const RetryFeature_1 = require("./feature/retry/RetryFeature");
const TelemetryFeature_1 = require("./feature/telemetry/TelemetryFeature");
const TestFeature_1 = require("./feature/test/TestFeature");
const TimeoutFeature_1 = require("./feature/timeout/TimeoutFeature");
const FEATURE_CLASS = {
    audit: AuditFeature_1.AuditFeature,
    clienttrack: ClienttrackFeature_1.ClienttrackFeature,
    idempotency: IdempotencyFeature_1.IdempotencyFeature,
    log: LogFeature_1.LogFeature,
    metrics: MetricsFeature_1.MetricsFeature,
    paging: PagingFeature_1.PagingFeature,
    ratelimit: RatelimitFeature_1.RatelimitFeature,
    retry: RetryFeature_1.RetryFeature,
    telemetry: TelemetryFeature_1.TelemetryFeature,
    test: TestFeature_1.TestFeature,
    timeout: TimeoutFeature_1.TimeoutFeature,
};
class Config {
    makeFeature(fn) {
        const fc = FEATURE_CLASS[fn];
        const fi = new fc();
        // TODO: errors etc
        return fi;
    }
    // False for a feature added at runtime via options.extend (station's
    // adopt path) - the constructor uses this to skip makeFeature for names
    // no generated class backs.
    hasFeature(fn) {
        return null != FEATURE_CLASS[fn];
    }
    main = {
        name: 'BluefinShieldconex',
        slug: "bluefin-shieldconex",
        version: "0.1.1",
        target: "ts",
    };
    feature = {
        audit: {
            "options": {
                "active": false,
                "actor": "anonymous",
                "max": 1000
            },
            "transport": "none"
        },
        clienttrack: {
            "options": {
                "active": false,
                "clientVersion": "0.0.1"
            },
            "transport": "none"
        },
        idempotency: {
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
        log: {
            "options": {
                "active": true
            },
            "transport": "none"
        },
        metrics: {
            "options": {
                "active": false
            },
            "transport": "none"
        },
        paging: {
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
        ratelimit: {
            "options": {
                "active": false,
                "burst": 5,
                "rate": 5
            },
            "transport": "wrap"
        },
        retry: {
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
        telemetry: {
            "options": {
                "active": false
            },
            "transport": "none"
        },
        test: {
            "options": {
                "active": false
            },
            "transport": "base"
        },
        timeout: {
            "options": {
                "active": false,
                "ms": 30000
            },
            "transport": "wrap"
        },
    };
    options = {
        base: "https://secure-cert.shieldconex.com/api",
        auth: {
            prefix: 'Basic',
            basic: true,
        },
        headers: {
            "content-type": "application/json"
        },
        entity: {
            detokenize: {},
            tokenize: {},
            tokenize_batch: {},
            tokenize_read: {},
            validate: {},
        }
    };
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
                                "res": "`body.values`"
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
                                "res": "`body.values`"
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
    };
}
const config = new Config();
exports.config = config;
//# sourceMappingURL=Config.js.map