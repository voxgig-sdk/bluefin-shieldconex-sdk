// Typed models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return the
// `Value` enum), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support.
#![allow(dead_code, non_snake_case, unused_imports)]

use crate::utility::voxgigstruct::Value;

/// Detokenize is the typed data model for the detokenize entity.
#[derive(Debug, Clone)]
pub struct Detokenize {
    pub batch: Option<Vec<Value>>,
    pub bfid: Option<String>,
    pub message_id: Option<String>,
    pub name: Option<String>,
    pub reference: Option<String>,
    pub value: Option<Vec<Value>>,
}

/// DetokenizeListMatch is the typed request payload for Detokenize.list.
#[derive(Debug, Clone)]
pub struct DetokenizeListMatch {
    pub batch: Option<Vec<Value>>,
    pub bfid: Option<String>,
    pub message_id: Option<String>,
    pub name: Option<String>,
    pub reference: Option<String>,
    pub value: Option<Vec<Value>>,
}

/// DetokenizeCreateData is the typed request payload for Detokenize.create.
#[derive(Debug, Clone)]
pub struct DetokenizeCreateData {
    pub batch: Option<Vec<Value>>,
    pub bfid: Option<String>,
    pub message_id: Option<String>,
    pub name: Option<String>,
    pub reference: Option<String>,
    pub value: Option<Vec<Value>>,
}

/// Tokenize is the typed data model for the tokenize entity.
#[derive(Debug, Clone)]
pub struct Tokenize {
    pub batch: Option<Vec<Value>>,
    pub bfid: Option<String>,
    pub message_id: Option<String>,
    pub name: Option<String>,
    pub reference: Option<String>,
    pub template_ref: String,
    pub value: Option<Vec<Value>>,
}

/// TokenizeListMatch is the typed request payload for Tokenize.list.
#[derive(Debug, Clone)]
pub struct TokenizeListMatch {
    pub batch: Option<Vec<Value>>,
    pub bfid: Option<String>,
    pub message_id: Option<String>,
    pub name: Option<String>,
    pub reference: Option<String>,
    pub template_ref: Option<String>,
    pub value: Option<Vec<Value>>,
}

/// TokenizeCreateData is the typed request payload for Tokenize.create.
#[derive(Debug, Clone)]
pub struct TokenizeCreateData {
    pub batch: Option<Vec<Value>>,
    pub bfid: Option<String>,
    pub message_id: Option<String>,
    pub name: Option<String>,
    pub reference: Option<String>,
    pub template_ref: String,
    pub value: Option<Vec<Value>>,
}

/// TokenizeBatch is the typed data model for the tokenize_batch entity.
#[derive(Debug, Clone)]
pub struct TokenizeBatch {
    pub batch: Option<Vec<Value>>,
    pub message_id: Option<String>,
    pub reference: Option<String>,
}

/// TokenizeBatchCreateData is the typed request payload for TokenizeBatch.create.
#[derive(Debug, Clone)]
pub struct TokenizeBatchCreateData {
    pub batch: Option<Vec<Value>>,
    pub message_id: Option<String>,
    pub reference: Option<String>,
}

/// TokenizeRead is the typed data model for the tokenize_read entity.
#[derive(Debug, Clone)]
pub struct TokenizeRead {
    pub bfid: Option<String>,
    pub message_id: Option<String>,
    pub reference: Option<String>,
    pub state: Option<std::collections::HashMap<String, Value>>,
    pub value: Option<Vec<Value>>,
}

/// TokenizeReadCreateData is the typed request payload for TokenizeRead.create.
#[derive(Debug, Clone)]
pub struct TokenizeReadCreateData {
    pub bfid: Option<String>,
    pub message_id: Option<String>,
    pub reference: Option<String>,
    pub state: Option<std::collections::HashMap<String, Value>>,
    pub value: Option<Vec<Value>>,
}

/// Validate is the typed data model for the validate entity.
#[derive(Debug, Clone)]
pub struct Validate {
    pub message_id: Option<String>,
    pub reference: Option<String>,
    pub template_ref: String,
}

/// ValidateCreateData is the typed request payload for Validate.create.
#[derive(Debug, Clone)]
pub struct ValidateCreateData {
    pub message_id: Option<String>,
    pub reference: Option<String>,
    pub template_ref: String,
}

