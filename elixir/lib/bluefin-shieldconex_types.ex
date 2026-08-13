# Typed models for the BluefinShieldconex SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels. The SDK carries data as string-keyed struct value
# nodes, so each alias is an open string-keyed map; the @typedoc member lists
# document the concrete shapes. Do not edit by hand.

defmodule BluefinShieldconex.Types do
  @moduledoc """
  Documented shapes for the BluefinShieldconex SDK entities and operation payloads.

  Every alias resolves to an open string-keyed map because the SDK carries
  data as string-keyed struct value nodes; consult each type's member list for
  the concrete field/param types.
  """

  @typedoc """
  Detokenize entity data model.

  Members:
    * `"batches"` — list() (optional)
    * `"bfid"` — String.t() (optional)
    * `"messageId"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"values"` — list() (optional)
  """
  @type detokenize :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Detokenize list.

  Members:
    * `"batches"` — list() (optional)
    * `"bfid"` — String.t() (optional)
    * `"messageId"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"values"` — list() (optional)
  """
  @type detokenize_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Detokenize create.

  Members:
    * `"batches"` — list() (optional)
    * `"bfid"` — String.t() (optional)
    * `"messageId"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"values"` — list() (optional)
  """
  @type detokenize_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Tokenize entity data model.

  Members:
    * `"batches"` — list() (optional)
    * `"bfid"` — String.t() (optional)
    * `"messageId"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"templateRef"` — String.t() (required)
    * `"value"` — String.t() (optional)
    * `"values"` — list() (optional)
  """
  @type tokenize :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Tokenize list.

  Members:
    * `"batches"` — list() (optional)
    * `"bfid"` — String.t() (optional)
    * `"messageId"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"templateRef"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"values"` — list() (optional)
  """
  @type tokenize_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Tokenize create.

  Members:
    * `"batches"` — list() (optional)
    * `"bfid"` — String.t() (optional)
    * `"messageId"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"templateRef"` — String.t() (required)
    * `"value"` — String.t() (optional)
    * `"values"` — list() (optional)
  """
  @type tokenize_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  TokenizeBatch entity data model.

  Members:
    * `"batches"` — list() (optional)
    * `"messageId"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
  """
  @type tokenize_batch :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for TokenizeBatch create.

  Members:
    * `"batches"` — list() (optional)
    * `"messageId"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
  """
  @type tokenize_batch_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  TokenizeRead entity data model.

  Members:
    * `"bfid"` — String.t() (optional)
    * `"messageId"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"state"` — map() (optional)
    * `"values"` — list() (optional)
  """
  @type tokenize_read :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for TokenizeRead create.

  Members:
    * `"bfid"` — String.t() (optional)
    * `"messageId"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"state"` — map() (optional)
    * `"values"` — list() (optional)
  """
  @type tokenize_read_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Validate entity data model.

  Members:
    * `"messageId"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"templateRef"` — String.t() (required)
  """
  @type validate :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Validate create.

  Members:
    * `"messageId"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"templateRef"` — String.t() (required)
  """
  @type validate_create_data :: %{optional(String.t()) => any()}

end
