package voxgig.bluefinshieldconexsdk.core

// Typed reference models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These case classes are documentation/DX reference shapes ONLY. The SDK ops
// take and return the loose object model (java.util.Map[String, Object] /
// Object) at runtime, so these types are not wired into the op signatures —
// use them to describe a payload before converting it to a map. Every
// component is a boxed (nullable) type, so an optional (req:false) key needs
// no distinct rendering.

object BluefinShieldconexTypes {

  final case class Detokenize(batches: java.util.List[Object], bfid: String, messageId: String, name: String, reference: String, value: String, values: java.util.List[Object])

  final case class DetokenizeListMatch(batches: java.util.List[Object], bfid: String, messageId: String, name: String, reference: String, value: String, values: java.util.List[Object])

  final case class DetokenizeCreateData(batches: java.util.List[Object], bfid: String, messageId: String, name: String, reference: String, value: String, values: java.util.List[Object])

  final case class Tokenize(batches: java.util.List[Object], bfid: String, messageId: String, name: String, reference: String, templateRef: String, value: String, values: java.util.List[Object])

  final case class TokenizeListMatch(batches: java.util.List[Object], bfid: String, messageId: String, name: String, reference: String, templateRef: String, value: String, values: java.util.List[Object])

  final case class TokenizeCreateData(batches: java.util.List[Object], bfid: String, messageId: String, name: String, reference: String, templateRef: String, value: String, values: java.util.List[Object])

  final case class TokenizeBatch(batches: java.util.List[Object], messageId: String, reference: String)

  final case class TokenizeBatchCreateData(batches: java.util.List[Object], messageId: String, reference: String)

  final case class TokenizeRead(bfid: String, messageId: String, reference: String, state: java.util.Map[String, Object], values: java.util.List[Object])

  final case class TokenizeReadCreateData(bfid: String, messageId: String, reference: String, state: java.util.Map[String, Object], values: java.util.List[Object])

  final case class Validate(messageId: String, reference: String, templateRef: String)

  final case class ValidateCreateData(messageId: String, reference: String, templateRef: String)

}
