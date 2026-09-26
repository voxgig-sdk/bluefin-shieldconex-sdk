// Generated API configuration (mirrors go/rust core/config).

const std = @import("std");
const h = @import("helpers.zig");
const types = @import("types.zig");
const Value = h.Value;
const Feature = types.Feature;

pub fn make_config() Value {
    return h.jo(&.{
        .{ "main", h.jo(&.{
            .{ "name", h.vstr("BluefinShieldconex") },
            .{ "slug", h.vstr("bluefin-shieldconex") },
            .{ "version", h.vstr("0.1.1") },
            .{ "target", h.vstr("zig") },
        }) },
        .{ "feature", h.jo(&.{
            .{ "audit", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "actor", h.vstr("anonymous") },
                    .{ "max", h.vnum(1000) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "sink", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "clienttrack", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "clientVersion", h.vstr("0.0.1") },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "clientName", h.vstr("`$STRING`") },
                    .{ "clientVersion", h.vstr("`$STRING`") },
                    .{ "headers", h.vstr("`$MAP`") },
                    .{ "idgen", h.vstr("`$FUNCTION`") },
                    .{ "sessionId", h.vstr("`$STRING`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "debug", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "max", h.vnum(100) },
                    .{ "redact", h.ja(&.{
                        h.vstr("authorization"),
                        h.vstr("cookie"),
                        h.vstr("set-cookie"),
                        h.vstr("api-key"),
                        h.vstr("apikey"),
                        h.vstr("x-api-key"),
                        h.vstr("idempotency-key"),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "onEntry", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "idempotency", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "header", h.vstr("Idempotency-Key") },
                    .{ "methods", h.ja(&.{
                        h.vstr("POST"),
                        h.vstr("PUT"),
                        h.vstr("PATCH"),
                        h.vstr("DELETE"),
                    }) },
                    .{ "ops", h.ja(&.{
                        h.vstr("create"),
                        h.vstr("update"),
                        h.vstr("remove"),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "keygen", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "log", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(true) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "level", h.vstr("`$STRING`") },
                    .{ "logger", h.vstr("`$ANY`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "metrics", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "paging", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "afterVar", h.vstr("after") },
                    .{ "cursorParam", h.vstr("cursor") },
                    .{ "firstVar", h.vstr("first") },
                    .{ "limitParam", h.vstr("limit") },
                    .{ "pageParam", h.vstr("page") },
                    .{ "startPage", h.vnum(1) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "limit", h.vstr("`$NUMBER`") },
                    .{ "ops", h.vstr("`$LIST`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "ratelimit", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "burst", h.vnum(5) },
                    .{ "rate", h.vnum(5) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "retry", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "factor", h.vnum(2) },
                    .{ "maxDelay", h.vnum(2000) },
                    .{ "minDelay", h.vnum(50) },
                    .{ "retries", h.vnum(2) },
                    .{ "statuses", h.ja(&.{
                        h.vnum(408),
                        h.vnum(425),
                        h.vnum(429),
                        h.vnum(500),
                        h.vnum(502),
                        h.vnum(503),
                        h.vnum(504),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "jitter", h.vstr("`$BOOLEAN`") },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "telemetry", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "exporter", h.vstr("`$FUNCTION`") },
                    .{ "headers", h.vstr("`$MAP`") },
                    .{ "idgen", h.vstr("`$FUNCTION`") },
                    .{ "now", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "test", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "entity", h.vstr("`$MAP`") },
                    .{ "net", h.vstr("`$MAP`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("base") },
            }) },
            .{ "timeout", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "ms", h.vnum(30000) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "clearTimer", h.vstr("`$FUNCTION`") },
                    .{ "setTimer", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
        }) },
        .{ "options", h.jo(&.{
            .{ "base", h.vstr("https://secure-cert.shieldconex.com/api") },
            .{ "auth", h.jo(&.{
                .{ "prefix", h.vstr("Basic") },
                .{ "basic", h.vbool(true) },
            }) },
            .{ "headers", h.jo(&.{
                .{ "content-type", h.vstr("application/json") },
            }) },
            .{ "entity", h.jo(&.{
                .{ "detokenize", h.omap() },
                .{ "tokenize", h.omap() },
                .{ "tokenize_batch", h.omap() },
                .{ "tokenize_read", h.omap() },
                .{ "validate", h.omap() },
            }) },
        }) },
        .{ "entity", h.jo(&.{
            .{ "detokenize", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("batches") },
                        .{ "title", h.vstr("Batches") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "op", h.jo(&.{
                            .{ "create", h.jo(&.{
                                .{ "req", h.vbool(true) },
                                .{ "type", h.vstr("`$ARRAY`") },
                            }) },
                        }) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("bfid") },
                        .{ "title", h.vstr("Bfid") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "op", h.jo(&.{
                            .{ "create", h.jo(&.{
                                .{ "req", h.vbool(true) },
                                .{ "type", h.vstr("`$STRING`") },
                            }) },
                        }) },
                        .{ "short", h.vstr("The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("messageId") },
                        .{ "title", h.vstr("Message Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Message Id") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Field Name.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("reference") },
                        .{ "title", h.vstr("Reference") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Request Reference.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("value") },
                        .{ "title", h.vstr("Value") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Field Value.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("values") },
                        .{ "title", h.vstr("Values") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "op", h.jo(&.{
                            .{ "create", h.jo(&.{
                                .{ "req", h.vbool(true) },
                                .{ "type", h.vstr("`$ARRAY`") },
                            }) },
                        }) },
                    }),
                }) },
                .{ "name", h.vstr("detokenize") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/tokenization/batch/detokenize") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("tokenization") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("batch") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("detokenize") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("tokenization"),
                                    h.vstr("batch"),
                                    h.vstr("detokenize"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/tokenization/detokenize") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("tokenization") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("detokenize") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("tokenization"),
                                    h.vstr("detokenize"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/healthcheck/detokenize") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("healthcheck") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("detokenize") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("healthcheck"),
                                    h.vstr("detokenize"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.values`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("bfid") },
                                            .{ "orig", h.vstr("bfid") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("field_name") },
                                            .{ "orig", h.vstr("field_name") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("field_value") },
                                            .{ "orig", h.vstr("field_value") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("reference") },
                                            .{ "orig", h.vstr("reference") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("bfid"),
                                        h.vstr("field_name"),
                                        h.vstr("field_value"),
                                        h.vstr("reference"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "tokenize", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("batches") },
                        .{ "title", h.vstr("Batches") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "op", h.jo(&.{
                            .{ "create", h.jo(&.{
                                .{ "req", h.vbool(true) },
                                .{ "type", h.vstr("`$ARRAY`") },
                            }) },
                        }) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("bfid") },
                        .{ "title", h.vstr("Bfid") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "op", h.jo(&.{
                            .{ "create", h.jo(&.{
                                .{ "req", h.vbool(true) },
                                .{ "type", h.vstr("`$STRING`") },
                            }) },
                        }) },
                        .{ "short", h.vstr("The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("messageId") },
                        .{ "title", h.vstr("Message Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Message Id") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Field Name.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("reference") },
                        .{ "title", h.vstr("Reference") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Request Reference.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("templateRef") },
                        .{ "title", h.vstr("Template Ref") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Template Reference") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("value") },
                        .{ "title", h.vstr("Value") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Field Value.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("values") },
                        .{ "title", h.vstr("Values") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "op", h.jo(&.{
                            .{ "create", h.jo(&.{
                                .{ "req", h.vbool(true) },
                                .{ "type", h.vstr("`$ARRAY`") },
                            }) },
                        }) },
                    }),
                }) },
                .{ "name", h.vstr("tokenize") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/tokenization/batch/tokenize") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("tokenization") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("batch") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("tokenize") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("tokenization"),
                                    h.vstr("batch"),
                                    h.vstr("tokenize"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("omit") },
                                            .{ "orig", h.vstr("omit") },
                                            .{ "type", h.vstr("`$NUMBER`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("omit"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/tokenization/tokenize") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("tokenization") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("tokenize") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("tokenization"),
                                    h.vstr("tokenize"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("omit") },
                                            .{ "orig", h.vstr("omit") },
                                            .{ "type", h.vstr("`$NUMBER`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("omit"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/tokenization/delete") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("tokenization") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("delete") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("tokenization"),
                                    h.vstr("delete"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/healthcheck/tokenize") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("healthcheck") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("tokenize") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("healthcheck"),
                                    h.vstr("tokenize"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.values`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("field_name") },
                                            .{ "orig", h.vstr("field_name") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("field_value") },
                                            .{ "orig", h.vstr("field_value") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("reference") },
                                            .{ "orig", h.vstr("reference") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("template_ref") },
                                            .{ "orig", h.vstr("template_ref") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("field_name"),
                                        h.vstr("field_value"),
                                        h.vstr("reference"),
                                        h.vstr("template_ref"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "tokenize_batch", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("batches") },
                        .{ "title", h.vstr("Batches") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "op", h.jo(&.{
                            .{ "create", h.jo(&.{
                                .{ "req", h.vbool(true) },
                                .{ "type", h.vstr("`$ARRAY`") },
                            }) },
                        }) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("messageId") },
                        .{ "title", h.vstr("Message Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Message Id") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("reference") },
                        .{ "title", h.vstr("Reference") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Request Reference.") },
                    }),
                }) },
                .{ "name", h.vstr("tokenize_batch") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/tokenization/batch/delete") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("tokenization") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("batch") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("delete") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("tokenization"),
                                    h.vstr("batch"),
                                    h.vstr("delete"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/tokenization/batch/read") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("tokenization") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("batch") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("read") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("tokenization"),
                                    h.vstr("batch"),
                                    h.vstr("read"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "tokenize_read", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("bfid") },
                        .{ "title", h.vstr("Bfid") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "op", h.jo(&.{
                            .{ "create", h.jo(&.{
                                .{ "req", h.vbool(true) },
                                .{ "type", h.vstr("`$STRING`") },
                            }) },
                        }) },
                        .{ "short", h.vstr("The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("messageId") },
                        .{ "title", h.vstr("Message Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Message Id") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("reference") },
                        .{ "title", h.vstr("Reference") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Request Reference.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("state") },
                        .{ "title", h.vstr("State") },
                        .{ "type", h.vstr("`$OBJECT`") },
                        .{ "short", h.vstr("Tokenized State Data (if available)") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("values") },
                        .{ "title", h.vstr("Values") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                }) },
                .{ "name", h.vstr("tokenize_read") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/tokenization/read") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("tokenization") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("read") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("tokenization"),
                                    h.vstr("read"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "validate", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("messageId") },
                        .{ "title", h.vstr("Message Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Message Id") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("reference") },
                        .{ "title", h.vstr("Reference") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Request Reference.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("templateRef") },
                        .{ "title", h.vstr("Template Ref") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Template Reference.") },
                    }),
                }) },
                .{ "name", h.vstr("validate") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/partner/validate") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("partner") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("validate") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("partner"),
                                    h.vstr("validate"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/template/validate") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("template") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("validate") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("template"),
                                    h.vstr("validate"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
        }) },
    });
}

// SHARED CONFIG (sdkgen rung L2).
//
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client. Above the
// size threshold make_config re-parses the whole embedded JSON, so this is the
// difference between parsing the model once and once per client.
//
// Value nodes are arena-allocated and reference-stable, so the shared value is
// genuinely one structure, not a copy.
var shared_config_val: ?Value = null;

/// The process-wide config, built once on first use.
///
/// The returned Value SHARES its nodes: treat it as read-only. Callers that
/// need to mutate should use make_config, which always returns a fresh copy.
pub fn shared_config() Value {
    if (shared_config_val) |c| return c;
    const c = make_config();
    shared_config_val = c;
    return c;
}

pub fn make_feature(name: []const u8) Feature {
    if (std.mem.eql(u8, name, "audit")) return @import("../feature/audit.zig").AuditFeature.make();
    if (std.mem.eql(u8, name, "cache")) return @import("../feature/cache.zig").CacheFeature.make();
    if (std.mem.eql(u8, name, "clienttrack")) return @import("../feature/clienttrack.zig").ClienttrackFeature.make();
    if (std.mem.eql(u8, name, "cost")) return @import("../feature/cost.zig").CostFeature.make();
    if (std.mem.eql(u8, name, "debug")) return @import("../feature/debug.zig").DebugFeature.make();
    if (std.mem.eql(u8, name, "idempotency")) return @import("../feature/idempotency.zig").IdempotencyFeature.make();
    if (std.mem.eql(u8, name, "log")) return @import("../feature/log.zig").LogFeature.make();
    if (std.mem.eql(u8, name, "metrics")) return @import("../feature/metrics.zig").MetricsFeature.make();
    if (std.mem.eql(u8, name, "netsim")) return @import("../feature/netsim.zig").NetsimFeature.make();
    if (std.mem.eql(u8, name, "paging")) return @import("../feature/paging.zig").PagingFeature.make();
    if (std.mem.eql(u8, name, "proxy")) return @import("../feature/proxy.zig").ProxyFeature.make();
    if (std.mem.eql(u8, name, "ratelimit")) return @import("../feature/ratelimit.zig").RatelimitFeature.make();
    if (std.mem.eql(u8, name, "rbac")) return @import("../feature/rbac.zig").RbacFeature.make();
    if (std.mem.eql(u8, name, "retry")) return @import("../feature/retry.zig").RetryFeature.make();
    if (std.mem.eql(u8, name, "streaming")) return @import("../feature/streaming.zig").StreamingFeature.make();
    if (std.mem.eql(u8, name, "telemetry")) return @import("../feature/telemetry.zig").TelemetryFeature.make();
    if (std.mem.eql(u8, name, "test")) return @import("../feature/test.zig").TestFeature.make();
    if (std.mem.eql(u8, name, "timeout")) return @import("../feature/timeout.zig").TimeoutFeature.make();
    return @import("../feature/base.zig").BaseFeature.make();
}
