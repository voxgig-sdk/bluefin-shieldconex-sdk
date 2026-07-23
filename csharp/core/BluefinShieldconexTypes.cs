// Typed reference models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These records are documentation/DX reference shapes ONLY. The SDK ops take
// and return the loose object model (Dictionary<string, object?> / object?) at
// runtime, so these types are not wired into the op signatures — use them to
// describe a payload before converting it to a dictionary. Optional (req:false)
// keys are modelled as nullable properties.

namespace BluefinShieldconexSdk.Types;

public record Detokenize
{
    public List<object?>? batch { get; init; }
    public string? bfid { get; init; }
    public string? message_id { get; init; }
    public string? name { get; init; }
    public string? reference { get; init; }
    public List<object?>? value { get; init; }
}

public record DetokenizeListMatch
{
    public List<object?>? batch { get; init; }
    public string? bfid { get; init; }
    public string? message_id { get; init; }
    public string? name { get; init; }
    public string? reference { get; init; }
    public List<object?>? value { get; init; }
}

public record DetokenizeCreateData
{
    public List<object?>? batch { get; init; }
    public string? bfid { get; init; }
    public string? message_id { get; init; }
    public string? name { get; init; }
    public string? reference { get; init; }
    public List<object?>? value { get; init; }
}

public record Tokenize
{
    public List<object?>? batch { get; init; }
    public string? bfid { get; init; }
    public string? message_id { get; init; }
    public string? name { get; init; }
    public string? reference { get; init; }
    public string template_ref { get; init; }
    public List<object?>? value { get; init; }
}

public record TokenizeListMatch
{
    public List<object?>? batch { get; init; }
    public string? bfid { get; init; }
    public string? message_id { get; init; }
    public string? name { get; init; }
    public string? reference { get; init; }
    public string? template_ref { get; init; }
    public List<object?>? value { get; init; }
}

public record TokenizeCreateData
{
    public List<object?>? batch { get; init; }
    public string? bfid { get; init; }
    public string? message_id { get; init; }
    public string? name { get; init; }
    public string? reference { get; init; }
    public string template_ref { get; init; }
    public List<object?>? value { get; init; }
}

public record TokenizeBatch
{
    public List<object?>? batch { get; init; }
    public string? message_id { get; init; }
    public string? reference { get; init; }
}

public record TokenizeBatchCreateData
{
    public List<object?>? batch { get; init; }
    public string? message_id { get; init; }
    public string? reference { get; init; }
}

public record TokenizeRead
{
    public string? bfid { get; init; }
    public string? message_id { get; init; }
    public string? reference { get; init; }
    public Dictionary<string, object?>? state { get; init; }
    public List<object?>? value { get; init; }
}

public record TokenizeReadCreateData
{
    public string? bfid { get; init; }
    public string? message_id { get; init; }
    public string? reference { get; init; }
    public Dictionary<string, object?>? state { get; init; }
    public List<object?>? value { get; init; }
}

public record Validate
{
    public string? message_id { get; init; }
    public string? reference { get; init; }
    public string template_ref { get; init; }
}

public record ValidateCreateData
{
    public string? message_id { get; init; }
    public string? reference { get; init; }
    public string template_ref { get; init; }
}

