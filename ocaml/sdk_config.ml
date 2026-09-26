(* Generated API configuration (mirrors go core/config.go).
 *
 * make_config () — the embedded API model as a voxgig struct value.
 * make_feature name — the N-feature-safe factory the client uses. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Sdk_features

let make_config () : value =
  (jo [
    ("main", (jo [
      ("name", (Str "BluefinShieldconex"));
      ("slug", (Str "bluefin-shieldconex"));
      ("version", (Str "0.1.1"));
      ("target", (Str "ocaml")) ]));
    ("feature", (jo [
      ("audit", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("actor", (Str "anonymous"));
          ("max", (Num (1000.))) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("sink", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("clienttrack", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("clientVersion", (Str "0.0.1")) ]));
        ("optspec", (jo [
          ("clientName", (Str "`$STRING`"));
          ("clientVersion", (Str "`$STRING`"));
          ("headers", (Str "`$MAP`"));
          ("idgen", (Str "`$FUNCTION`"));
          ("sessionId", (Str "`$STRING`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("debug", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("max", (Num (100.)));
          ("redact", (ja [
            (Str "authorization");
            (Str "cookie");
            (Str "set-cookie");
            (Str "api-key");
            (Str "apikey");
            (Str "x-api-key");
            (Str "idempotency-key") ])) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("onEntry", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("idempotency", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("header", (Str "Idempotency-Key"));
          ("methods", (ja [
            (Str "POST");
            (Str "PUT");
            (Str "PATCH");
            (Str "DELETE") ]));
          ("ops", (ja [
            (Str "create");
            (Str "update");
            (Str "remove") ])) ]));
        ("optspec", (jo [
          ("keygen", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("log", (jo [
        ("options", (jo [
          ("active", (Bool true)) ]));
        ("optspec", (jo [
          ("level", (Str "`$STRING`"));
          ("logger", (Str "`$ANY`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("metrics", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("paging", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("afterVar", (Str "after"));
          ("cursorParam", (Str "cursor"));
          ("firstVar", (Str "first"));
          ("limitParam", (Str "limit"));
          ("pageParam", (Str "page"));
          ("startPage", (Num (1.))) ]));
        ("optspec", (jo [
          ("limit", (Str "`$NUMBER`"));
          ("ops", (Str "`$LIST`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("ratelimit", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("burst", (Num (5.)));
          ("rate", (Num (5.))) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("retry", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("factor", (Num (2.)));
          ("maxDelay", (Num (2000.)));
          ("minDelay", (Num (50.)));
          ("retries", (Num (2.)));
          ("statuses", (ja [
            (Num (408.));
            (Num (425.));
            (Num (429.));
            (Num (500.));
            (Num (502.));
            (Num (503.));
            (Num (504.)) ])) ]));
        ("optspec", (jo [
          ("jitter", (Str "`$BOOLEAN`"));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("telemetry", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("exporter", (Str "`$FUNCTION`"));
          ("headers", (Str "`$MAP`"));
          ("idgen", (Str "`$FUNCTION`"));
          ("now", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("test", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("entity", (Str "`$MAP`"));
          ("net", (Str "`$MAP`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "base")) ]));
      ("timeout", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("ms", (Num (30000.))) ]));
        ("optspec", (jo [
          ("clearTimer", (Str "`$FUNCTION`"));
          ("setTimer", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ])) ]));
    ("options", (jo [
      ("base", (Str "https://secure-cert.shieldconex.com/api"));
      ("auth", (jo [
        ("prefix", (Str "Basic"));
        ("basic", (Bool true)) ]));
      ("headers", (jo [
        ("content-type", (Str "application/json")) ]));
      ("entity", (jo [
        ("detokenize", (empty_map ()));
        ("tokenize", (empty_map ()));
        ("tokenize_batch", (empty_map ()));
        ("tokenize_read", (empty_map ()));
        ("validate", (empty_map ())) ])) ]));
    ("entity", (jo [
      ("detokenize", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "batches"));
            ("title", (Str "Batches"));
            ("type", (Str "`$ARRAY`"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ])) ]);
          (jo [
            ("name", (Str "bfid"));
            ("title", (Str "Bfid"));
            ("type", (Str "`$STRING`"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ]));
            ("short", (Str "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).")) ]);
          (jo [
            ("name", (Str "messageId"));
            ("title", (Str "Message Id"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Message Id")) ]);
          (jo [
            ("name", (Str "name"));
            ("title", (Str "Name"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Field Name.")) ]);
          (jo [
            ("name", (Str "reference"));
            ("title", (Str "Reference"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Request Reference.")) ]);
          (jo [
            ("name", (Str "value"));
            ("title", (Str "Value"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Field Value.")) ]);
          (jo [
            ("name", (Str "values"));
            ("title", (Str "Values"));
            ("type", (Str "`$ARRAY`"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ])) ]) ]));
        ("name", (Str "detokenize"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/batch/detokenize"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "tokenization")) ]);
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("lit", (Str "detokenize")) ]) ]));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "batch");
                  (Str "detokenize") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/detokenize"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "tokenization")) ]);
                  (jo [
                    ("lit", (Str "detokenize")) ]) ]));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "detokenize") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/healthcheck/detokenize"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "healthcheck")) ]);
                  (jo [
                    ("lit", (Str "detokenize")) ]) ]));
                ("parts", (ja [
                  (Str "healthcheck");
                  (Str "detokenize") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.values`")) ]));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("name", (Str "bfid"));
                      ("orig", (Str "bfid"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query"));
                      ("reqd", (Bool true)) ]);
                    (jo [
                      ("name", (Str "field_name"));
                      ("orig", (Str "field_name"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]);
                    (jo [
                      ("name", (Str "field_value"));
                      ("orig", (Str "field_value"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]);
                    (jo [
                      ("name", (Str "reference"));
                      ("orig", (Str "reference"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "bfid");
                    (Str "field_name");
                    (Str "field_value");
                    (Str "reference") ])) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("tokenize", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "batches"));
            ("title", (Str "Batches"));
            ("type", (Str "`$ARRAY`"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ])) ]);
          (jo [
            ("name", (Str "bfid"));
            ("title", (Str "Bfid"));
            ("type", (Str "`$STRING`"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ]));
            ("short", (Str "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).")) ]);
          (jo [
            ("name", (Str "messageId"));
            ("title", (Str "Message Id"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Message Id")) ]);
          (jo [
            ("name", (Str "name"));
            ("title", (Str "Name"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Field Name.")) ]);
          (jo [
            ("name", (Str "reference"));
            ("title", (Str "Reference"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Request Reference.")) ]);
          (jo [
            ("name", (Str "templateRef"));
            ("title", (Str "Template Ref"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Template Reference")) ]);
          (jo [
            ("name", (Str "value"));
            ("title", (Str "Value"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Field Value.")) ]);
          (jo [
            ("name", (Str "values"));
            ("title", (Str "Values"));
            ("type", (Str "`$ARRAY`"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ])) ]) ]));
        ("name", (Str "tokenize"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/batch/tokenize"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "tokenization")) ]);
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("lit", (Str "tokenize")) ]) ]));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "batch");
                  (Str "tokenize") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("name", (Str "omit"));
                      ("orig", (Str "omit"));
                      ("type", (Str "`$NUMBER`"));
                      ("kind", (Str "query")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "omit") ])) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/tokenize"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "tokenization")) ]);
                  (jo [
                    ("lit", (Str "tokenize")) ]) ]));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "tokenize") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("name", (Str "omit"));
                      ("orig", (Str "omit"));
                      ("type", (Str "`$NUMBER`"));
                      ("kind", (Str "query")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "omit") ])) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/delete"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "tokenization")) ]);
                  (jo [
                    ("lit", (Str "delete")) ]) ]));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "delete") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/healthcheck/tokenize"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "healthcheck")) ]);
                  (jo [
                    ("lit", (Str "tokenize")) ]) ]));
                ("parts", (ja [
                  (Str "healthcheck");
                  (Str "tokenize") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.values`")) ]));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("name", (Str "field_name"));
                      ("orig", (Str "field_name"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]);
                    (jo [
                      ("name", (Str "field_value"));
                      ("orig", (Str "field_value"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]);
                    (jo [
                      ("name", (Str "reference"));
                      ("orig", (Str "reference"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]);
                    (jo [
                      ("name", (Str "template_ref"));
                      ("orig", (Str "template_ref"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "field_name");
                    (Str "field_value");
                    (Str "reference");
                    (Str "template_ref") ])) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("tokenize_batch", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "batches"));
            ("title", (Str "Batches"));
            ("type", (Str "`$ARRAY`"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ])) ]);
          (jo [
            ("name", (Str "messageId"));
            ("title", (Str "Message Id"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Message Id")) ]);
          (jo [
            ("name", (Str "reference"));
            ("title", (Str "Reference"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Request Reference.")) ]) ]));
        ("name", (Str "tokenize_batch"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/batch/delete"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "tokenization")) ]);
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("lit", (Str "delete")) ]) ]));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "batch");
                  (Str "delete") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/batch/read"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "tokenization")) ]);
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("lit", (Str "read")) ]) ]));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "batch");
                  (Str "read") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("tokenize_read", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "bfid"));
            ("title", (Str "Bfid"));
            ("type", (Str "`$STRING`"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ]));
            ("short", (Str "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).")) ]);
          (jo [
            ("name", (Str "messageId"));
            ("title", (Str "Message Id"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Message Id")) ]);
          (jo [
            ("name", (Str "reference"));
            ("title", (Str "Reference"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Request Reference.")) ]);
          (jo [
            ("name", (Str "state"));
            ("title", (Str "State"));
            ("type", (Str "`$OBJECT`"));
            ("short", (Str "Tokenized State Data (if available)")) ]);
          (jo [
            ("name", (Str "values"));
            ("title", (Str "Values"));
            ("type", (Str "`$ARRAY`")) ]) ]));
        ("name", (Str "tokenize_read"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/read"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "tokenization")) ]);
                  (jo [
                    ("lit", (Str "read")) ]) ]));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "read") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("validate", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "messageId"));
            ("title", (Str "Message Id"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Message Id")) ]);
          (jo [
            ("name", (Str "reference"));
            ("title", (Str "Reference"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Request Reference.")) ]);
          (jo [
            ("name", (Str "templateRef"));
            ("title", (Str "Template Ref"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Template Reference.")) ]) ]));
        ("name", (Str "validate"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/partner/validate"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "partner")) ]);
                  (jo [
                    ("lit", (Str "validate")) ]) ]));
                ("parts", (ja [
                  (Str "partner");
                  (Str "validate") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/template/validate"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "template")) ]);
                  (jo [
                    ("lit", (Str "validate")) ]) ]));
                ("parts", (ja [
                  (Str "template");
                  (Str "validate") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ])) ])) ])

(* The plugin definitions the model selected, per feature: none - no
 * plugin-bearing feature is active in this SDK. *)
let feature_plugins (_name : string) = []

let make_feature (name : string) : feature =
  match name with
  | "audit" -> audit_feature ()
  | "clienttrack" -> clienttrack_feature ()
  | "debug" -> debug_feature ()
  | "idempotency" -> idempotency_feature ()
  | "log" -> log_feature ()
  | "metrics" -> metrics_feature ()
  | "paging" -> paging_feature ()
  | "ratelimit" -> ratelimit_feature ()
  | "retry" -> retry_feature ()
  | "telemetry" -> telemetry_feature ()
  | "test" -> test_feature ()
  | "timeout" -> timeout_feature ()
  | _ -> base_feature ()
