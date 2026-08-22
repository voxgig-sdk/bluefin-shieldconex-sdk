// BluefinShieldconex SDK - generated model configuration and feature
// factory. GENERATED from the API model - do not edit by hand.

namespace BluefinShieldconexSdk;

public static class SdkConfig
{
    public static Dictionary<string, object?> MakeConfig()
    {
        return new Dictionary<string, object?>
        {
            ["main"] = new Dictionary<string, object?>
            {
                ["name"] = "BluefinShieldconex",
                ["slug"] = "bluefin-shieldconex",
                ["version"] = "0.1.1",
                ["target"] = "csharp",
            },
            ["feature"] = new Dictionary<string, object?>
            {
                ["test"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                },
            },
            ["options"] = new Dictionary<string, object?>
            {
                ["base"] = "https://secure-cert.shieldconex.com/api",
                ["auth"] = new Dictionary<string, object?>
                {
                    ["prefix"] = "Basic",
                },
                ["headers"] = new Dictionary<string, object?>
                {
                    ["content-type"] = "application/json",
                },
                ["entity"] = new Dictionary<string, object?>
                {
                    ["detokenize"] = new Dictionary<string, object?>(),
                    ["tokenize"] = new Dictionary<string, object?>(),
                    ["tokenize_batch"] = new Dictionary<string, object?>(),
                    ["tokenize_read"] = new Dictionary<string, object?>(),
                    ["validate"] = new Dictionary<string, object?>(),
                },
            },
            ["entity"] = new Dictionary<string, object?>
            {
                ["detokenize"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "batches",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$ARRAY`",
                                },
                            },
                            ["type"] = "`$ARRAY`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "bfid",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["short"] = "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "messageId",
                            ["short"] = "Message Id",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["short"] = "Field Name.",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "reference",
                            ["short"] = "Request Reference.",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "value",
                            ["short"] = "Field Value.",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "values",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$ARRAY`",
                                },
                            },
                            ["type"] = "`$ARRAY`",
                        },
                    },
                    ["name"] = "detokenize",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/batch/detokenize",
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "batch",
                                        "detokenize",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/detokenize",
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "detokenize",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                },
                            },
                        },
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "query",
                                                ["name"] = "bfid",
                                                ["orig"] = "bfid",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "query",
                                                ["name"] = "field_name",
                                                ["orig"] = "field_name",
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "query",
                                                ["name"] = "field_value",
                                                ["orig"] = "field_value",
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "query",
                                                ["name"] = "reference",
                                                ["orig"] = "reference",
                                                ["type"] = "`$STRING`",
                                            },
                                        },
                                    },
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/healthcheck/detokenize",
                                    ["parts"] = new List<object?>
                                    {
                                        "healthcheck",
                                        "detokenize",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "bfid",
                                            "field_name",
                                            "field_value",
                                            "reference",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.values`",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["tokenize"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "batches",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$ARRAY`",
                                },
                            },
                            ["type"] = "`$ARRAY`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "bfid",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["short"] = "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "messageId",
                            ["short"] = "Message Id",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["short"] = "Field Name.",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "reference",
                            ["short"] = "Request Reference.",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "templateRef",
                            ["req"] = true,
                            ["short"] = "Template Reference",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "value",
                            ["short"] = "Field Value.",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "values",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$ARRAY`",
                                },
                            },
                            ["type"] = "`$ARRAY`",
                        },
                    },
                    ["name"] = "tokenize",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "query",
                                                ["name"] = "omit",
                                                ["orig"] = "omit",
                                                ["type"] = "`$NUMBER`",
                                            },
                                        },
                                    },
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/batch/tokenize",
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "batch",
                                        "tokenize",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "omit",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "query",
                                                ["name"] = "omit",
                                                ["orig"] = "omit",
                                                ["type"] = "`$NUMBER`",
                                            },
                                        },
                                    },
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/tokenize",
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "tokenize",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "omit",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/delete",
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "delete",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                },
                            },
                        },
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "query",
                                                ["name"] = "field_name",
                                                ["orig"] = "field_name",
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "query",
                                                ["name"] = "field_value",
                                                ["orig"] = "field_value",
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "query",
                                                ["name"] = "reference",
                                                ["orig"] = "reference",
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "query",
                                                ["name"] = "template_ref",
                                                ["orig"] = "template_ref",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                            },
                                        },
                                    },
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/healthcheck/tokenize",
                                    ["parts"] = new List<object?>
                                    {
                                        "healthcheck",
                                        "tokenize",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "field_name",
                                            "field_value",
                                            "reference",
                                            "template_ref",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.values`",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["tokenize_batch"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "batches",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$ARRAY`",
                                },
                            },
                            ["type"] = "`$ARRAY`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "messageId",
                            ["short"] = "Message Id",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "reference",
                            ["short"] = "Request Reference.",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["name"] = "tokenize_batch",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/batch/delete",
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "batch",
                                        "delete",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/batch/read",
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "batch",
                                        "read",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["tokenize_read"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "bfid",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["short"] = "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "messageId",
                            ["short"] = "Message Id",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "reference",
                            ["short"] = "Request Reference.",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "state",
                            ["short"] = "Tokenized State Data (if available)",
                            ["type"] = "`$OBJECT`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "values",
                            ["type"] = "`$ARRAY`",
                        },
                    },
                    ["name"] = "tokenize_read",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/read",
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "read",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["validate"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "messageId",
                            ["short"] = "Message Id",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "reference",
                            ["short"] = "Request Reference.",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "templateRef",
                            ["req"] = true,
                            ["short"] = "Template Reference.",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["name"] = "validate",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/partner/validate",
                                    ["parts"] = new List<object?>
                                    {
                                        "partner",
                                        "validate",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/template/validate",
                                    ["parts"] = new List<object?>
                                    {
                                        "template",
                                        "validate",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
            },
        };
    }

    private static readonly Lazy<Dictionary<string, object?>> SharedConfigVal =
        new(MakeConfig);

    // The process-wide config, built once on first use.
    //
    // The returned dictionary is SHARED: treat it as read-only. Callers that
    // need to mutate should use MakeConfig, which always returns a fresh copy.
    public static Dictionary<string, object?> SharedConfig()
    {
        return SharedConfigVal.Value;
    }

    public static Feature.BaseFeature MakeFeature(string name)
    {
        switch (name)
        {
            case "test":
                return new Feature.TestFeature();
            default:
                return new Feature.BaseFeature();
        }
    }
}
