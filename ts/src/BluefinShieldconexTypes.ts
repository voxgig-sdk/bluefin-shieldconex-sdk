// Typed models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Detokenize {
  batch?: any[]
  bfid?: string
  message_id?: string
  name?: string
  reference?: string
  value?: any[]
}

export interface DetokenizeListMatch {
  batch?: any[]
  bfid?: string
  message_id?: string
  name?: string
  reference?: string
  value?: any[]
}

export interface DetokenizeCreateData {
  batch?: any[]
  bfid?: string
  message_id?: string
  name?: string
  reference?: string
  value?: any[]
}

export interface Tokenize {
  batch?: any[]
  bfid?: string
  message_id?: string
  name?: string
  reference?: string
  template_ref: string
  value?: any[]
}

export interface TokenizeListMatch {
  batch?: any[]
  bfid?: string
  message_id?: string
  name?: string
  reference?: string
  template_ref?: string
  value?: any[]
}

export interface TokenizeCreateData {
  batch?: any[]
  bfid?: string
  message_id?: string
  name?: string
  reference?: string
  template_ref: string
  value?: any[]
}

export interface TokenizeBatch {
  batch?: any[]
  message_id?: string
  reference?: string
}

export interface TokenizeBatchCreateData {
  batch?: any[]
  message_id?: string
  reference?: string
}

export interface TokenizeRead {
  bfid?: string
  message_id?: string
  reference?: string
  state?: Record<string, any>
  value?: any[]
}

export interface TokenizeReadCreateData {
  bfid?: string
  message_id?: string
  reference?: string
  state?: Record<string, any>
  value?: any[]
}

export interface Validate {
  message_id?: string
  reference?: string
  template_ref: string
}

export interface ValidateCreateData {
  message_id?: string
  reference?: string
  template_ref: string
}

