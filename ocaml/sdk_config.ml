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
        ("transport", (Str "none")) ]));
      ("clienttrack", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("clientVersion", (Str "0.0.1")) ]));
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
        ("transport", (Str "none")) ]));
      ("log", (jo [
        ("options", (jo [
          ("active", (Bool true)) ]));
        ("transport", (Str "none")) ]));
      ("metrics", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
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
        ("transport", (Str "none")) ]));
      ("ratelimit", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("burst", (Num (5.)));
          ("rate", (Num (5.))) ]));
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
        ("transport", (Str "wrap")) ]));
      ("telemetry", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("transport", (Str "none")) ]));
      ("test", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("transport", (Str "base")) ]));
      ("timeout", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("ms", (Num (30000.))) ]));
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
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ]));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "bfid"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ]));
            ("short", (Str "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request)."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "messageId"));
            ("short", (Str "Message Id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "name"));
            ("short", (Str "Field Name."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "reference"));
            ("short", (Str "Request Reference."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "value"));
            ("short", (Str "Field Value."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "values"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ]));
            ("type", (Str "`$ARRAY`")) ]) ]));
        ("name", (Str "detokenize"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/batch/detokenize"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "batch");
                  (Str "detokenize") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/detokenize"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "detokenize") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("kind", (Str "query"));
                      ("name", (Str "bfid"));
                      ("orig", (Str "bfid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("kind", (Str "query"));
                      ("name", (Str "field_name"));
                      ("orig", (Str "field_name"));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("kind", (Str "query"));
                      ("name", (Str "field_value"));
                      ("orig", (Str "field_value"));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("kind", (Str "query"));
                      ("name", (Str "reference"));
                      ("orig", (Str "reference"));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/healthcheck/detokenize"));
                ("parts", (ja [
                  (Str "healthcheck");
                  (Str "detokenize") ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "bfid");
                    (Str "field_name");
                    (Str "field_value");
                    (Str "reference") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.values`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("tokenize", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "batches"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ]));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "bfid"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ]));
            ("short", (Str "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request)."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "messageId"));
            ("short", (Str "Message Id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "name"));
            ("short", (Str "Field Name."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "reference"));
            ("short", (Str "Request Reference."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "templateRef"));
            ("req", (Bool true));
            ("short", (Str "Template Reference"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "value"));
            ("short", (Str "Field Value."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "values"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ]));
            ("type", (Str "`$ARRAY`")) ]) ]));
        ("name", (Str "tokenize"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("kind", (Str "query"));
                      ("name", (Str "omit"));
                      ("orig", (Str "omit"));
                      ("type", (Str "`$NUMBER`")) ]) ])) ]));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/batch/tokenize"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "batch");
                  (Str "tokenize") ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "omit") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("kind", (Str "query"));
                      ("name", (Str "omit"));
                      ("orig", (Str "omit"));
                      ("type", (Str "`$NUMBER`")) ]) ])) ]));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/tokenize"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "tokenize") ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "omit") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/delete"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "delete") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("kind", (Str "query"));
                      ("name", (Str "field_name"));
                      ("orig", (Str "field_name"));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("kind", (Str "query"));
                      ("name", (Str "field_value"));
                      ("orig", (Str "field_value"));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("kind", (Str "query"));
                      ("name", (Str "reference"));
                      ("orig", (Str "reference"));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("kind", (Str "query"));
                      ("name", (Str "template_ref"));
                      ("orig", (Str "template_ref"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/healthcheck/tokenize"));
                ("parts", (ja [
                  (Str "healthcheck");
                  (Str "tokenize") ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "field_name");
                    (Str "field_value");
                    (Str "reference");
                    (Str "template_ref") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.values`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("tokenize_batch", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "batches"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ]));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "messageId"));
            ("short", (Str "Message Id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "reference"));
            ("short", (Str "Request Reference."));
            ("type", (Str "`$STRING`")) ]) ]));
        ("name", (Str "tokenize_batch"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/batch/delete"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "batch");
                  (Str "delete") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/batch/read"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "batch");
                  (Str "read") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("tokenize_read", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "bfid"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ]));
            ("short", (Str "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request)."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "messageId"));
            ("short", (Str "Message Id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "reference"));
            ("short", (Str "Request Reference."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "state"));
            ("short", (Str "Tokenized State Data (if available)"));
            ("type", (Str "`$OBJECT`")) ]);
          (jo [
            ("name", (Str "values"));
            ("type", (Str "`$ARRAY`")) ]) ]));
        ("name", (Str "tokenize_read"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/read"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "read") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("validate", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "messageId"));
            ("short", (Str "Message Id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "reference"));
            ("short", (Str "Request Reference."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "templateRef"));
            ("req", (Bool true));
            ("short", (Str "Template Reference."));
            ("type", (Str "`$STRING`")) ]) ]));
        ("name", (Str "validate"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/partner/validate"));
                ("parts", (ja [
                  (Str "partner");
                  (Str "validate") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/template/validate"));
                ("parts", (ja [
                  (Str "template");
                  (Str "validate") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ])) ])) ])

let make_feature (name : string) : feature =
  match name with
  | "audit" -> audit_feature ()
  | "clienttrack" -> clienttrack_feature ()
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
