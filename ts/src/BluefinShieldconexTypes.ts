// Typed models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Detokenize {
  batches?: any[]
  bfid?: string
  messageId?: string
  name?: string
  reference?: string
  value?: string
  values?: any[]
}

export interface DetokenizeListMatch {
  bfid: string
  field_name?: string
  field_value?: string
  reference?: string
}

export interface DetokenizeCreateData {
  batches?: any[]
  bfid?: string
  messageId?: string
  name?: string
  reference?: string
  value?: string
  values?: any[]
}

export interface Tokenize {
  batches?: any[]
  bfid?: string
  messageId?: string
  name?: string
  reference?: string
  templateRef: string
  value?: string
  values?: any[]
}

export interface TokenizeListMatch {
  field_name?: string
  field_value?: string
  reference?: string
  template_ref: string
}

export interface TokenizeCreateData {
  omit?: number
  batches?: any[]
  bfid?: string
  messageId?: string
  name?: string
  reference?: string
  templateRef: string
  value?: string
  values?: any[]
}

export interface TokenizeBatch {
  batches?: any[]
  messageId?: string
  reference?: string
}

export interface TokenizeBatchCreateData {
  batches?: any[]
  messageId?: string
  reference?: string
}

export interface TokenizeRead {
  bfid?: string
  messageId?: string
  reference?: string
  state?: Record<string, any>
  values?: any[]
}

export interface TokenizeReadCreateData {
  bfid?: string
  messageId?: string
  reference?: string
  state?: Record<string, any>
  values?: any[]
}

export interface Validate {
  messageId?: string
  reference?: string
  templateRef: string
}

export interface ValidateCreateData {
  messageId?: string
  reference?: string
  templateRef: string
}

