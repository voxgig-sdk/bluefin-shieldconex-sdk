(* Generated tokenize_batch entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "tokenize_batch.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.tokenize_batch client Noval in
      check_str "name" ent.e_name "tokenize_batch")
