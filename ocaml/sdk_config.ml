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
      ("name", (Str "BluefinShieldconex")) ]));
    ("feature", (jo [
      ("test", (jo [
        ("options", (jo [
          ("active", (Bool false)) ])) ])) ]));
    ("options", (jo [
      ("base", (Str "https://secure-cert.shieldconex.com/api"));
      ("headers", (jo [
        ("content-type", (Str "application/json")) ]));
      ("entity", (jo [
        ("detokenize", (empty_map ()));
        ("tokenize", (empty_map ()));
        ("tokenize_batch", (empty_map ()));
        ("tokenize_read", (empty_map ()));
        ("validate", (empty_map ())) ]));
      ("auth", (jo [
        ("prefix", (Str "Basic")) ])) ]));
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
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "messageId"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "name"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "reference"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "value"));
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
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
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
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "messageId"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "name"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "reference"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "templateRef"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "value"));
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
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
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
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "reference"));
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
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "messageId"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "reference"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "state"));
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
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "reference"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "templateRef"));
            ("req", (Bool true));
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
  | "test" -> test_feature ()
  | _ -> base_feature ()
