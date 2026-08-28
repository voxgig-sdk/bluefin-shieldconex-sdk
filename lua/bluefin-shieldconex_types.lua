-- Typed models for the BluefinShieldconex SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Detokenize
---@field batches? table
---@field bfid? string
---@field messageId? string
---@field name? string
---@field reference? string
---@field value? string
---@field values? table

---@class DetokenizeListMatch
---@field bfid string
---@field field_name? string
---@field field_value? string
---@field reference? string

---@class DetokenizeCreateData
---@field batches? table
---@field bfid? string
---@field messageId? string
---@field name? string
---@field reference? string
---@field value? string
---@field values? table

---@class Tokenize
---@field batches? table
---@field bfid? string
---@field messageId? string
---@field name? string
---@field reference? string
---@field templateRef string
---@field value? string
---@field values? table

---@class TokenizeListMatch
---@field field_name? string
---@field field_value? string
---@field reference? string
---@field template_ref string

---@class TokenizeCreateData
---@field omit? number
---@field batches? table
---@field bfid? string
---@field messageId? string
---@field name? string
---@field reference? string
---@field templateRef string
---@field value? string
---@field values? table

---@class TokenizeBatch
---@field batches? table
---@field messageId? string
---@field reference? string

---@class TokenizeBatchCreateData
---@field batches? table
---@field messageId? string
---@field reference? string

---@class TokenizeRead
---@field bfid? string
---@field messageId? string
---@field reference? string
---@field state? table
---@field values? table

---@class TokenizeReadCreateData
---@field bfid? string
---@field messageId? string
---@field reference? string
---@field state? table
---@field values? table

---@class Validate
---@field messageId? string
---@field reference? string
---@field templateRef string

---@class ValidateCreateData
---@field messageId? string
---@field reference? string
---@field templateRef string

local M = {}

return M
