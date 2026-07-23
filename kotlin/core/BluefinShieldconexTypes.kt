package voxgig.bluefinshieldconexsdk.core

// Typed reference models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These types are documentation/DX reference shapes ONLY. The SDK ops take and
// return the loose object model (MutableMap<String, Any?> / Any?) at runtime,
// so these types are not wired into the op signatures — use them to describe a
// payload before converting it to a map. Every component is a nullable type, so
// an optional (req:false) key needs no distinct rendering.

@Suppress("unused")
object BluefinShieldconexTypes {

  data class Detokenize(val batch: List<Any?>?, val bfid: String?, val message_id: String?, val name: String?, val reference: String?, val value: List<Any?>?)

  data class DetokenizeListMatch(val batch: List<Any?>?, val bfid: String?, val message_id: String?, val name: String?, val reference: String?, val value: List<Any?>?)

  data class DetokenizeCreateData(val batch: List<Any?>?, val bfid: String?, val message_id: String?, val name: String?, val reference: String?, val value: List<Any?>?)

  data class Tokenize(val batch: List<Any?>?, val bfid: String?, val message_id: String?, val name: String?, val reference: String?, val template_ref: String?, val value: List<Any?>?)

  data class TokenizeListMatch(val batch: List<Any?>?, val bfid: String?, val message_id: String?, val name: String?, val reference: String?, val template_ref: String?, val value: List<Any?>?)

  data class TokenizeCreateData(val batch: List<Any?>?, val bfid: String?, val message_id: String?, val name: String?, val reference: String?, val template_ref: String?, val value: List<Any?>?)

  data class TokenizeBatch(val batch: List<Any?>?, val message_id: String?, val reference: String?)

  data class TokenizeBatchCreateData(val batch: List<Any?>?, val message_id: String?, val reference: String?)

  data class TokenizeRead(val bfid: String?, val message_id: String?, val reference: String?, val state: Map<String, Any?>?, val value: List<Any?>?)

  data class TokenizeReadCreateData(val bfid: String?, val message_id: String?, val reference: String?, val state: Map<String, Any?>?, val value: List<Any?>?)

  data class Validate(val message_id: String?, val reference: String?, val template_ref: String?)

  data class ValidateCreateData(val message_id: String?, val reference: String?, val template_ref: String?)

}
