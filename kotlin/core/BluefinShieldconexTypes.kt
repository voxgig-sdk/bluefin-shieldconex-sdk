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

  data class Detokenize(val batches: List<Any?>?, val bfid: String?, val messageId: String?, val name: String?, val reference: String?, val value: String?, val values: List<Any?>?)

  data class DetokenizeListMatch(val batches: List<Any?>?, val bfid: String?, val messageId: String?, val name: String?, val reference: String?, val value: String?, val values: List<Any?>?)

  data class DetokenizeCreateData(val batches: List<Any?>?, val bfid: String?, val messageId: String?, val name: String?, val reference: String?, val value: String?, val values: List<Any?>?)

  data class Tokenize(val batches: List<Any?>?, val bfid: String?, val messageId: String?, val name: String?, val reference: String?, val templateRef: String?, val value: String?, val values: List<Any?>?)

  data class TokenizeListMatch(val batches: List<Any?>?, val bfid: String?, val messageId: String?, val name: String?, val reference: String?, val templateRef: String?, val value: String?, val values: List<Any?>?)

  data class TokenizeCreateData(val batches: List<Any?>?, val bfid: String?, val messageId: String?, val name: String?, val reference: String?, val templateRef: String?, val value: String?, val values: List<Any?>?)

  data class TokenizeBatch(val batches: List<Any?>?, val messageId: String?, val reference: String?)

  data class TokenizeBatchCreateData(val batches: List<Any?>?, val messageId: String?, val reference: String?)

  data class TokenizeRead(val bfid: String?, val messageId: String?, val reference: String?, val state: Map<String, Any?>?, val values: List<Any?>?)

  data class TokenizeReadCreateData(val bfid: String?, val messageId: String?, val reference: String?, val state: Map<String, Any?>?, val values: List<Any?>?)

  data class Validate(val messageId: String?, val reference: String?, val templateRef: String?)

  data class ValidateCreateData(val messageId: String?, val reference: String?, val templateRef: String?)

}
