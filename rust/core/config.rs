// Generated API configuration (mirrors go core/config.go).

use std::cell::RefCell;
use std::rc::Rc;

use crate::core::types::FeatureRef;
use crate::utility::voxgigstruct::Value;

pub fn make_config() -> Value {
    Value::map_of([
        ("main".to_string(), Value::map_of([
            ("name".to_string(), Value::str("BluefinShieldconex")),
            ("slug".to_string(), Value::str("bluefin-shieldconex")),
            ("version".to_string(), Value::str("0.0.1")),
            ("target".to_string(), Value::str("rust")),
        ])),
        ("feature".to_string(), Value::map_of([
            ("test".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                ])),
            ])),
        ])),
        ("options".to_string(), Value::map_of([
            ("base".to_string(), Value::str("https://secure-cert.shieldconex.com/api")),
            ("auth".to_string(), Value::map_of([
                ("prefix".to_string(), Value::str("Basic")),
            ])),
            ("headers".to_string(), Value::map_of([
                ("content-type".to_string(), Value::str("application/json")),
            ])),
            ("entity".to_string(), Value::map_of([
                ("detokenize".to_string(), Value::empty_map()),
                ("tokenize".to_string(), Value::empty_map()),
                ("tokenize_batch".to_string(), Value::empty_map()),
                ("tokenize_read".to_string(), Value::empty_map()),
                ("validate".to_string(), Value::empty_map()),
            ])),
        ])),
        ("entity".to_string(), Value::map_of([
            ("detokenize".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("batches")),
                        ("op".to_string(), Value::map_of([
                            ("create".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(true)),
                                ("type".to_string(), Value::str("`$ARRAY`")),
                            ])),
                        ])),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("bfid")),
                        ("op".to_string(), Value::map_of([
                            ("create".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(true)),
                                ("type".to_string(), Value::str("`$STRING`")),
                            ])),
                        ])),
                        ("short".to_string(), Value::str("The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("messageId")),
                        ("short".to_string(), Value::str("Message Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("short".to_string(), Value::str("Field Name.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("reference")),
                        ("short".to_string(), Value::str("Request Reference.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("value")),
                        ("short".to_string(), Value::str("Field Value.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("values")),
                        ("op".to_string(), Value::map_of([
                            ("create".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(true)),
                                ("type".to_string(), Value::str("`$ARRAY`")),
                            ])),
                        ])),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                ])),
                ("name".to_string(), Value::str("detokenize")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/tokenization/batch/detokenize")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("tokenization"),
                                    Value::str("batch"),
                                    Value::str("detokenize"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/tokenization/detokenize")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("tokenization"),
                                    Value::str("detokenize"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::map_of([
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("query")),
                                            ("name".to_string(), Value::str("bfid")),
                                            ("orig".to_string(), Value::str("bfid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("query")),
                                            ("name".to_string(), Value::str("field_name")),
                                            ("orig".to_string(), Value::str("field_name")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("query")),
                                            ("name".to_string(), Value::str("field_value")),
                                            ("orig".to_string(), Value::str("field_value")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("query")),
                                            ("name".to_string(), Value::str("reference")),
                                            ("orig".to_string(), Value::str("reference")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                    ])),
                                ])),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/healthcheck/detokenize")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("healthcheck"),
                                    Value::str("detokenize"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("bfid"),
                                        Value::str("field_name"),
                                        Value::str("field_value"),
                                        Value::str("reference"),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("tokenize".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("batches")),
                        ("op".to_string(), Value::map_of([
                            ("create".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(true)),
                                ("type".to_string(), Value::str("`$ARRAY`")),
                            ])),
                        ])),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("bfid")),
                        ("op".to_string(), Value::map_of([
                            ("create".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(true)),
                                ("type".to_string(), Value::str("`$STRING`")),
                            ])),
                        ])),
                        ("short".to_string(), Value::str("The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("messageId")),
                        ("short".to_string(), Value::str("Message Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("short".to_string(), Value::str("Field Name.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("reference")),
                        ("short".to_string(), Value::str("Request Reference.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("templateRef")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Template Reference")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("value")),
                        ("short".to_string(), Value::str("Field Value.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("values")),
                        ("op".to_string(), Value::map_of([
                            ("create".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(true)),
                                ("type".to_string(), Value::str("`$ARRAY`")),
                            ])),
                        ])),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                ])),
                ("name".to_string(), Value::str("tokenize")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::map_of([
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("query")),
                                            ("name".to_string(), Value::str("omit")),
                                            ("orig".to_string(), Value::str("omit")),
                                            ("type".to_string(), Value::str("`$NUMBER`")),
                                        ]),
                                    ])),
                                ])),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/tokenization/batch/tokenize")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("tokenization"),
                                    Value::str("batch"),
                                    Value::str("tokenize"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("omit"),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::map_of([
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("query")),
                                            ("name".to_string(), Value::str("omit")),
                                            ("orig".to_string(), Value::str("omit")),
                                            ("type".to_string(), Value::str("`$NUMBER`")),
                                        ]),
                                    ])),
                                ])),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/tokenization/tokenize")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("tokenization"),
                                    Value::str("tokenize"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("omit"),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/tokenization/delete")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("tokenization"),
                                    Value::str("delete"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::map_of([
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("query")),
                                            ("name".to_string(), Value::str("field_name")),
                                            ("orig".to_string(), Value::str("field_name")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("query")),
                                            ("name".to_string(), Value::str("field_value")),
                                            ("orig".to_string(), Value::str("field_value")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("query")),
                                            ("name".to_string(), Value::str("reference")),
                                            ("orig".to_string(), Value::str("reference")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("query")),
                                            ("name".to_string(), Value::str("template_ref")),
                                            ("orig".to_string(), Value::str("template_ref")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                    ])),
                                ])),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/healthcheck/tokenize")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("healthcheck"),
                                    Value::str("tokenize"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("field_name"),
                                        Value::str("field_value"),
                                        Value::str("reference"),
                                        Value::str("template_ref"),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("tokenize_batch".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("batches")),
                        ("op".to_string(), Value::map_of([
                            ("create".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(true)),
                                ("type".to_string(), Value::str("`$ARRAY`")),
                            ])),
                        ])),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("messageId")),
                        ("short".to_string(), Value::str("Message Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("reference")),
                        ("short".to_string(), Value::str("Request Reference.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("name".to_string(), Value::str("tokenize_batch")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/tokenization/batch/delete")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("tokenization"),
                                    Value::str("batch"),
                                    Value::str("delete"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/tokenization/batch/read")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("tokenization"),
                                    Value::str("batch"),
                                    Value::str("read"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("tokenize_read".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("bfid")),
                        ("op".to_string(), Value::map_of([
                            ("create".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(true)),
                                ("type".to_string(), Value::str("`$STRING`")),
                            ])),
                        ])),
                        ("short".to_string(), Value::str("The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("messageId")),
                        ("short".to_string(), Value::str("Message Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("reference")),
                        ("short".to_string(), Value::str("Request Reference.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("state")),
                        ("short".to_string(), Value::str("Tokenized State Data (if available)")),
                        ("type".to_string(), Value::str("`$OBJECT`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("values")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                ])),
                ("name".to_string(), Value::str("tokenize_read")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/tokenization/read")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("tokenization"),
                                    Value::str("read"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("validate".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("messageId")),
                        ("short".to_string(), Value::str("Message Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("reference")),
                        ("short".to_string(), Value::str("Request Reference.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("templateRef")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Template Reference.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("name".to_string(), Value::str("validate")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/partner/validate")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("partner"),
                                    Value::str("validate"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/template/validate")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("template"),
                                    Value::str("validate"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
        ])),
    ])
}

// SHARED CONFIG (sdkgen rung L2).
//
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client. Above the
// size threshold make_config re-parses the whole embedded JSON, so this is the
// difference between parsing the model once and once per client.
//
// THREAD-LOCAL, not a global: Value is Rc/RefCell-backed and so is neither
// Send nor Sync. One config per thread is the widest scope that is sound here,
// and the clone is an Rc bump, not a deep copy.
thread_local! {
    static SHARED_CONFIG: Value = make_config();
}

/// The per-thread config, built once on first use.
///
/// The returned Value SHARES its nodes: treat it as read-only. Callers that
/// need to mutate should use make_config, which always returns a fresh copy.
pub fn shared_config() -> Value {
    SHARED_CONFIG.with(|c| c.clone())
}

pub fn make_feature(name: &str) -> FeatureRef {
    match name {
        "test" => Rc::new(RefCell::new(crate::feature::test::TestFeature::new())),
        _ => Rc::new(RefCell::new(crate::feature::base::BaseFeature::new())),
    }
}
