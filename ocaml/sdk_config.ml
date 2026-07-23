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
            ("active", (Bool true));
            ("name", (Str "batch"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ]));
            ("req", (Bool false));
            ("type", (Str "`$ARRAY`"));
            ("index$", (Num (0.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "bfid"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ]));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (1.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "message_id"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (2.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "name"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (3.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "reference"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (4.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "value"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ]));
            ("req", (Bool false));
            ("type", (Str "`$ARRAY`"));
            ("index$", (Num (5.))) ]) ]));
        ("name", (Str "detokenize"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/batch/detokenize"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "batch");
                  (Str "detokenize") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/detokenize"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "detokenize") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (1.))) ]) ]));
            ("key$", (Str "create")) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "bfid"));
                      ("orig", (Str "bfid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "field_name"));
                      ("orig", (Str "field_name"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "field_value"));
                      ("orig", (Str "field_value"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "reference"));
                      ("orig", (Str "reference"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
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
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]) ]));
            ("key$", (Str "list")) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("tokenize", (jo [
        ("fields", (ja [
          (jo [
            ("active", (Bool true));
            ("name", (Str "batch"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ]));
            ("req", (Bool false));
            ("type", (Str "`$ARRAY`"));
            ("index$", (Num (0.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "bfid"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ]));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (1.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "message_id"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (2.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "name"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (3.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "reference"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (4.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "template_ref"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (5.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "value"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ]));
            ("req", (Bool false));
            ("type", (Str "`$ARRAY`"));
            ("index$", (Num (6.))) ]) ]));
        ("name", (Str "tokenize"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "omit"));
                      ("orig", (Str "omit"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$NUMBER`")) ]) ])) ]));
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
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "omit"));
                      ("orig", (Str "omit"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$NUMBER`")) ]) ])) ]));
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
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (1.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/delete"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "delete") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (2.))) ]) ]));
            ("key$", (Str "create")) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "field_name"));
                      ("orig", (Str "field_name"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "field_value"));
                      ("orig", (Str "field_value"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "reference"));
                      ("orig", (Str "reference"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "template_ref"));
                      ("orig", (Str "template_ref"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
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
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]) ]));
            ("key$", (Str "list")) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("tokenize_batch", (jo [
        ("fields", (ja [
          (jo [
            ("active", (Bool true));
            ("name", (Str "batch"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$ARRAY`")) ])) ]));
            ("req", (Bool false));
            ("type", (Str "`$ARRAY`"));
            ("index$", (Num (0.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "message_id"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (1.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "reference"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (2.))) ]) ]));
        ("name", (Str "tokenize_batch"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/batch/delete"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "batch");
                  (Str "delete") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/batch/read"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "batch");
                  (Str "read") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (1.))) ]) ]));
            ("key$", (Str "create")) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("tokenize_read", (jo [
        ("fields", (ja [
          (jo [
            ("active", (Bool true));
            ("name", (Str "bfid"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ]));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (0.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "message_id"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (1.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "reference"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (2.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "state"));
            ("req", (Bool false));
            ("type", (Str "`$OBJECT`"));
            ("index$", (Num (3.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "value"));
            ("req", (Bool false));
            ("type", (Str "`$ARRAY`"));
            ("index$", (Num (4.))) ]) ]));
        ("name", (Str "tokenize_read"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/tokenization/read"));
                ("parts", (ja [
                  (Str "tokenization");
                  (Str "read") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]) ]));
            ("key$", (Str "create")) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("validate", (jo [
        ("fields", (ja [
          (jo [
            ("active", (Bool true));
            ("name", (Str "message_id"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (0.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "reference"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (1.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "template_ref"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (2.))) ]) ]));
        ("name", (Str "validate"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/partner/validate"));
                ("parts", (ja [
                  (Str "partner");
                  (Str "validate") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/template/validate"));
                ("parts", (ja [
                  (Str "template");
                  (Str "validate") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (1.))) ]) ]));
            ("key$", (Str "create")) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ])) ])) ])

let make_feature (name : string) : feature =
  match name with
  | "test" -> test_feature ()
  | _ -> base_feature ()
