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
    public ?array $batches = null;
    public ?string $bfid = null;
    public ?string $messageId = null;
    public ?string $name = null;
    public ?string $reference = null;
    public ?string $value = null;
    public ?array $values = null;
}

/** Request payload for Detokenize#list. */
class DetokenizeListMatch
{
    public string $bfid;
    public ?string $field_name = null;
    public ?string $field_value = null;
    public ?string $reference = null;
}

/** Request payload for Detokenize#create. */
class DetokenizeCreateData
{
    public ?array $batches = null;
    public ?string $bfid = null;
    public ?string $messageId = null;
    public ?string $name = null;
    public ?string $reference = null;
    public ?string $value = null;
    public ?array $values = null;
}

/** Tokenize entity data model. */
class Tokenize
{
    public ?array $batches = null;
    public ?string $bfid = null;
    public ?string $messageId = null;
    public ?string $name = null;
    public ?string $reference = null;
    public string $templateRef;
    public ?string $value = null;
    public ?array $values = null;
}

/** Request payload for Tokenize#list. */
class TokenizeListMatch
{
    public ?string $field_name = null;
    public ?string $field_value = null;
    public ?string $reference = null;
    public string $template_ref;
}

/** Request payload for Tokenize#create. */
class TokenizeCreateData
{
    public ?float $omit = null;
    public ?array $batches = null;
    public ?string $bfid = null;
    public ?string $messageId = null;
    public ?string $name = null;
    public ?string $reference = null;
    public string $templateRef;
    public ?string $value = null;
    public ?array $values = null;
}

/** TokenizeBatch entity data model. */
class TokenizeBatch
{
    public ?array $batches = null;
    public ?string $messageId = null;
    public ?string $reference = null;
}

/** Request payload for TokenizeBatch#create. */
class TokenizeBatchCreateData
{
    public ?array $batches = null;
    public ?string $messageId = null;
    public ?string $reference = null;
}

/** TokenizeRead entity data model. */
class TokenizeRead
{
    public ?string $bfid = null;
    public ?string $messageId = null;
    public ?string $reference = null;
    public ?array $state = null;
    public ?array $values = null;
}

/** Request payload for TokenizeRead#create. */
class TokenizeReadCreateData
{
    public ?string $bfid = null;
    public ?string $messageId = null;
    public ?string $reference = null;
    public ?array $state = null;
    public ?array $values = null;
}

/** Validate entity data model. */
class Validate
{
    public ?string $messageId = null;
    public ?string $reference = null;
    public string $templateRef;
}

/** Request payload for Validate#create. */
class ValidateCreateData
{
    public ?string $messageId = null;
    public ?string $reference = null;
    public string $templateRef;
}

