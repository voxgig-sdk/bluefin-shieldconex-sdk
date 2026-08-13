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
# @!attribute [rw] batches
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] value
#   @return [String, nil]
#
# @!attribute [rw] values
#   @return [Array, nil]
Detokenize = Struct.new(
  :batches,
  :bfid,
  :messageId,
  :name,
  :reference,
  :value,
  :values,
  keyword_init: true
)

# Request payload for Detokenize#list.
#
# @!attribute [rw] batches
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] value
#   @return [String, nil]
#
# @!attribute [rw] values
#   @return [Array, nil]
DetokenizeListMatch = Struct.new(
  :batches,
  :bfid,
  :messageId,
  :name,
  :reference,
  :value,
  :values,
  keyword_init: true
)

# Request payload for Detokenize#create.
#
# @!attribute [rw] batches
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] value
#   @return [String, nil]
#
# @!attribute [rw] values
#   @return [Array, nil]
DetokenizeCreateData = Struct.new(
  :batches,
  :bfid,
  :messageId,
  :name,
  :reference,
  :value,
  :values,
  keyword_init: true
)

# Tokenize entity data model.
#
# @!attribute [rw] batches
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] templateRef
#   @return [String]
#
# @!attribute [rw] value
#   @return [String, nil]
#
# @!attribute [rw] values
#   @return [Array, nil]
Tokenize = Struct.new(
  :batches,
  :bfid,
  :messageId,
  :name,
  :reference,
  :templateRef,
  :value,
  :values,
  keyword_init: true
)

# Request payload for Tokenize#list.
#
# @!attribute [rw] batches
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] templateRef
#   @return [String, nil]
#
# @!attribute [rw] value
#   @return [String, nil]
#
# @!attribute [rw] values
#   @return [Array, nil]
TokenizeListMatch = Struct.new(
  :batches,
  :bfid,
  :messageId,
  :name,
  :reference,
  :templateRef,
  :value,
  :values,
  keyword_init: true
)

# Request payload for Tokenize#create.
#
# @!attribute [rw] batches
#   @return [Array, nil]
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] templateRef
#   @return [String]
#
# @!attribute [rw] value
#   @return [String, nil]
#
# @!attribute [rw] values
#   @return [Array, nil]
TokenizeCreateData = Struct.new(
  :batches,
  :bfid,
  :messageId,
  :name,
  :reference,
  :templateRef,
  :value,
  :values,
  keyword_init: true
)

# TokenizeBatch entity data model.
#
# @!attribute [rw] batches
#   @return [Array, nil]
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
TokenizeBatch = Struct.new(
  :batches,
  :messageId,
  :reference,
  keyword_init: true
)

# Request payload for TokenizeBatch#create.
#
# @!attribute [rw] batches
#   @return [Array, nil]
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
TokenizeBatchCreateData = Struct.new(
  :batches,
  :messageId,
  :reference,
  keyword_init: true
)

# TokenizeRead entity data model.
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] state
#   @return [Hash, nil]
#
# @!attribute [rw] values
#   @return [Array, nil]
TokenizeRead = Struct.new(
  :bfid,
  :messageId,
  :reference,
  :state,
  :values,
  keyword_init: true
)

# Request payload for TokenizeRead#create.
#
# @!attribute [rw] bfid
#   @return [String, nil]
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] state
#   @return [Hash, nil]
#
# @!attribute [rw] values
#   @return [Array, nil]
TokenizeReadCreateData = Struct.new(
  :bfid,
  :messageId,
  :reference,
  :state,
  :values,
  keyword_init: true
)

# Validate entity data model.
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] templateRef
#   @return [String]
Validate = Struct.new(
  :messageId,
  :reference,
  :templateRef,
  keyword_init: true
)

# Request payload for Validate#create.
#
# @!attribute [rw] messageId
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] templateRef
#   @return [String]
ValidateCreateData = Struct.new(
  :messageId,
  :reference,
  :templateRef,
  keyword_init: true
)

