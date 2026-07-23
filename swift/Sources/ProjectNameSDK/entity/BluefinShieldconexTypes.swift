// Typed models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return the
// `Value` enum), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support.

import Foundation

/// Detokenize is the typed data model for the detokenize entity.
public struct Detokenize {
  public var batch: [Value]?
  public var bfid: String?
  public var messageId: String?
  public var name: String?
  public var reference: String?
  public var value: [Value]?
}

/// DetokenizeListMatch is the typed request payload for Detokenize.list.
public struct DetokenizeListMatch {
  public var batch: [Value]?
  public var bfid: String?
  public var messageId: String?
  public var name: String?
  public var reference: String?
  public var value: [Value]?
}

/// DetokenizeCreateData is the typed request payload for Detokenize.create.
public struct DetokenizeCreateData {
  public var batch: [Value]?
  public var bfid: String?
  public var messageId: String?
  public var name: String?
  public var reference: String?
  public var value: [Value]?
}

/// Tokenize is the typed data model for the tokenize entity.
public struct Tokenize {
  public var batch: [Value]?
  public var bfid: String?
  public var messageId: String?
  public var name: String?
  public var reference: String?
  public var templateRef: String
  public var value: [Value]?
}

/// TokenizeListMatch is the typed request payload for Tokenize.list.
public struct TokenizeListMatch {
  public var batch: [Value]?
  public var bfid: String?
  public var messageId: String?
  public var name: String?
  public var reference: String?
  public var templateRef: String?
  public var value: [Value]?
}

/// TokenizeCreateData is the typed request payload for Tokenize.create.
public struct TokenizeCreateData {
  public var batch: [Value]?
  public var bfid: String?
  public var messageId: String?
  public var name: String?
  public var reference: String?
  public var templateRef: String
  public var value: [Value]?
}

/// TokenizeBatch is the typed data model for the tokenize_batch entity.
public struct TokenizeBatch {
  public var batch: [Value]?
  public var messageId: String?
  public var reference: String?
}

/// TokenizeBatchCreateData is the typed request payload for TokenizeBatch.create.
public struct TokenizeBatchCreateData {
  public var batch: [Value]?
  public var messageId: String?
  public var reference: String?
}

/// TokenizeRead is the typed data model for the tokenize_read entity.
public struct TokenizeRead {
  public var bfid: String?
  public var messageId: String?
  public var reference: String?
  public var state: VMap?
  public var value: [Value]?
}

/// TokenizeReadCreateData is the typed request payload for TokenizeRead.create.
public struct TokenizeReadCreateData {
  public var bfid: String?
  public var messageId: String?
  public var reference: String?
  public var state: VMap?
  public var value: [Value]?
}

/// Validate is the typed data model for the validate entity.
public struct Validate {
  public var messageId: String?
  public var reference: String?
  public var templateRef: String
}

/// ValidateCreateData is the typed request payload for Validate.create.
public struct ValidateCreateData {
  public var messageId: String?
  public var reference: String?
  public var templateRef: String
}

