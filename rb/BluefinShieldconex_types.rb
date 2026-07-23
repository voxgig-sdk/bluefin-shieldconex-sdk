# frozen_string_literal: true

# Typed models for the BluefinShieldconex SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Detokenize entity data model.
#
# @!attribute [rw] batch
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] value
#   @return [Array, nil]
Detokenize = Struct.new(
  :batch,
  :bfid,
  :message_id,
  :name,
  :reference,
  :value,
  keyword_init: true
)

# Request payload for Detokenize#list.
#
# @!attribute [rw] batch
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] value
#   @return [Array, nil]
DetokenizeListMatch = Struct.new(
  :batch,
  :bfid,
  :message_id,
  :name,
  :reference,
  :value,
  keyword_init: true
)

# Request payload for Detokenize#create.
#
# @!attribute [rw] batch
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] value
#   @return [Array, nil]
DetokenizeCreateData = Struct.new(
  :batch,
  :bfid,
  :message_id,
  :name,
  :reference,
  :value,
  keyword_init: true
)

# Tokenize entity data model.
#
# @!attribute [rw] batch
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] template_ref
#   @return [String]
#
# @!attribute [rw] value
#   @return [Array, nil]
Tokenize = Struct.new(
  :batch,
  :bfid,
  :message_id,
  :name,
  :reference,
  :template_ref,
  :value,
  keyword_init: true
)

# Request payload for Tokenize#list.
#
# @!attribute [rw] batch
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] template_ref
#   @return [String, nil]
#
# @!attribute [rw] value
#   @return [Array, nil]
TokenizeListMatch = Struct.new(
  :batch,
  :bfid,
  :message_id,
  :name,
  :reference,
  :template_ref,
  :value,
  keyword_init: true
)

# Request payload for Tokenize#create.
#
# @!attribute [rw] batch
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] template_ref
#   @return [String]
#
# @!attribute [rw] value
#   @return [Array, nil]
TokenizeCreateData = Struct.new(
  :batch,
  :bfid,
  :message_id,
  :name,
  :reference,
  :template_ref,
  :value,
  keyword_init: true
)

# TokenizeBatch entity data model.
#
# @!attribute [rw] batch
#   @return [Array, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
TokenizeBatch = Struct.new(
  :batch,
  :message_id,
  :reference,
  keyword_init: true
)

# Request payload for TokenizeBatch#create.
#
# @!attribute [rw] batch
#   @return [Array, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
TokenizeBatchCreateData = Struct.new(
  :batch,
  :message_id,
  :reference,
  keyword_init: true
)

# TokenizeRead entity data model.
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] state
#   @return [Hash, nil]
#
# @!attribute [rw] value
#   @return [Array, nil]
TokenizeRead = Struct.new(
  :bfid,
  :message_id,
  :reference,
  :state,
  :value,
  keyword_init: true
)

# Request payload for TokenizeRead#create.
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] state
#   @return [Hash, nil]
#
# @!attribute [rw] value
#   @return [Array, nil]
TokenizeReadCreateData = Struct.new(
  :bfid,
  :message_id,
  :reference,
  :state,
  :value,
  keyword_init: true
)

# Validate entity data model.
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] template_ref
#   @return [String]
Validate = Struct.new(
  :message_id,
  :reference,
  :template_ref,
  keyword_init: true
)

# Request payload for Validate#create.
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] template_ref
#   @return [String]
ValidateCreateData = Struct.new(
  :message_id,
  :reference,
  :template_ref,
  keyword_init: true
)

