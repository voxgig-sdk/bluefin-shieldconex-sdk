<?php
declare(strict_types=1);

// Typed models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Detokenize entity data model. */
class Detokenize
{
    public ?array $batch = null;
    public ?string $bfid = null;
    public ?string $message_id = null;
    public ?string $name = null;
    public ?string $reference = null;
    public ?array $value = null;
}

/** Request payload for Detokenize#list. */
class DetokenizeListMatch
{
    public ?array $batch = null;
    public ?string $bfid = null;
    public ?string $message_id = null;
    public ?string $name = null;
    public ?string $reference = null;
    public ?array $value = null;
}

/** Request payload for Detokenize#create. */
class DetokenizeCreateData
{
    public ?array $batch = null;
    public ?string $bfid = null;
    public ?string $message_id = null;
    public ?string $name = null;
    public ?string $reference = null;
    public ?array $value = null;
}

/** Tokenize entity data model. */
class Tokenize
{
    public ?array $batch = null;
    public ?string $bfid = null;
    public ?string $message_id = null;
    public ?string $name = null;
    public ?string $reference = null;
    public string $template_ref;
    public ?array $value = null;
}

/** Request payload for Tokenize#list. */
class TokenizeListMatch
{
    public ?array $batch = null;
    public ?string $bfid = null;
    public ?string $message_id = null;
    public ?string $name = null;
    public ?string $reference = null;
    public ?string $template_ref = null;
    public ?array $value = null;
}

/** Request payload for Tokenize#create. */
class TokenizeCreateData
{
    public ?array $batch = null;
    public ?string $bfid = null;
    public ?string $message_id = null;
    public ?string $name = null;
    public ?string $reference = null;
    public string $template_ref;
    public ?array $value = null;
}

/** TokenizeBatch entity data model. */
class TokenizeBatch
{
    public ?array $batch = null;
    public ?string $message_id = null;
    public ?string $reference = null;
}

/** Request payload for TokenizeBatch#create. */
class TokenizeBatchCreateData
{
    public ?array $batch = null;
    public ?string $message_id = null;
    public ?string $reference = null;
}

/** TokenizeRead entity data model. */
class TokenizeRead
{
    public ?string $bfid = null;
    public ?string $message_id = null;
    public ?string $reference = null;
    public ?array $state = null;
    public ?array $value = null;
}

/** Request payload for TokenizeRead#create. */
class TokenizeReadCreateData
{
    public ?string $bfid = null;
    public ?string $message_id = null;
    public ?string $reference = null;
    public ?array $state = null;
    public ?array $value = null;
}

/** Validate entity data model. */
class Validate
{
    public ?string $message_id = null;
    public ?string $reference = null;
    public string $template_ref;
}

/** Request payload for Validate#create. */
class ValidateCreateData
{
    public ?string $message_id = null;
    public ?string $reference = null;
    public string $template_ref;
}

