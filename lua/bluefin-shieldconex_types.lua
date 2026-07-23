-- Typed models for the BluefinShieldconex SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Detokenize
---@field batch? table
---@field bfid? string
---@field message_id? string
---@field name? string
---@field reference? string
---@field value? table

---@class DetokenizeListMatch
---@field batch? table
---@field bfid? string
---@field message_id? string
---@field name? string
---@field reference? string
---@field value? table

---@class DetokenizeCreateData
---@field batch? table
---@field bfid? string
---@field message_id? string
---@field name? string
---@field reference? string
---@field value? table

---@class Tokenize
---@field batch? table
---@field bfid? string
---@field message_id? string
---@field name? string
---@field reference? string
---@field template_ref string
---@field value? table

---@class TokenizeListMatch
---@field batch? table
---@field bfid? string
---@field message_id? string
---@field name? string
---@field reference? string
---@field template_ref? string
---@field value? table

---@class TokenizeCreateData
---@field batch? table
---@field bfid? string
---@field message_id? string
---@field name? string
---@field reference? string
---@field template_ref string
---@field value? table

---@class TokenizeBatch
---@field batch? table
---@field message_id? string
---@field reference? string

---@class TokenizeBatchCreateData
---@field batch? table
---@field message_id? string
---@field reference? string

---@class TokenizeRead
---@field bfid? string
---@field message_id? string
---@field reference? string
---@field state? table
---@field value? table

---@class TokenizeReadCreateData
---@field bfid? string
---@field message_id? string
---@field reference? string
---@field state? table
---@field value? table

---@class Validate
---@field message_id? string
---@field reference? string
---@field template_ref string

---@class ValidateCreateData
---@field message_id? string
---@field reference? string
---@field template_ref string

local M = {}

return M
