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

  final case class Detokenize(batch: java.util.List[Object], bfid: String, message_id: String, name: String, reference: String, value: java.util.List[Object])

  final case class DetokenizeListMatch(batch: java.util.List[Object], bfid: String, message_id: String, name: String, reference: String, value: java.util.List[Object])

  final case class DetokenizeCreateData(batch: java.util.List[Object], bfid: String, message_id: String, name: String, reference: String, value: java.util.List[Object])

  final case class Tokenize(batch: java.util.List[Object], bfid: String, message_id: String, name: String, reference: String, template_ref: String, value: java.util.List[Object])

  final case class TokenizeListMatch(batch: java.util.List[Object], bfid: String, message_id: String, name: String, reference: String, template_ref: String, value: java.util.List[Object])

  final case class TokenizeCreateData(batch: java.util.List[Object], bfid: String, message_id: String, name: String, reference: String, template_ref: String, value: java.util.List[Object])

  final case class TokenizeBatch(batch: java.util.List[Object], message_id: String, reference: String)

  final case class TokenizeBatchCreateData(batch: java.util.List[Object], message_id: String, reference: String)

  final case class TokenizeRead(bfid: String, message_id: String, reference: String, state: java.util.Map[String, Object], value: java.util.List[Object])

  final case class TokenizeReadCreateData(bfid: String, message_id: String, reference: String, state: java.util.Map[String, Object], value: java.util.List[Object])

  final case class Validate(message_id: String, reference: String, template_ref: String)

  final case class ValidateCreateData(message_id: String, reference: String, template_ref: String)

}
