(* Generated tokenize_read entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "tokenize_read.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.tokenize_read client Noval in
      check_str "name" ent.e_name "tokenize_read")
