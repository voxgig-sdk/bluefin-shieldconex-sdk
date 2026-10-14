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
                ["audit"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["actor"] = "anonymous",
                        ["max"] = 1000,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["sink"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["clienttrack"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["clientVersion"] = "0.0.1",
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["clientName"] = "`$STRING`",
                        ["clientVersion"] = "`$STRING`",
                        ["headers"] = "`$MAP`",
                        ["idgen"] = "`$FUNCTION`",
                        ["sessionId"] = "`$STRING`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["debug"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["max"] = 100,
                        ["redact"] = new List<object?>
                        {
                            "authorization",
                            "cookie",
                            "set-cookie",
                            "api-key",
                            "apikey",
                            "x-api-key",
                            "idempotency-key",
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["onEntry"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["idempotency"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["header"] = "Idempotency-Key",
                        ["methods"] = new List<object?>
                        {
                            "POST",
                            "PUT",
                            "PATCH",
                            "DELETE",
                        },
                        ["ops"] = new List<object?>
                        {
                            "create",
                            "update",
                            "remove",
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["keygen"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["log"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = true,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["level"] = "`$STRING`",
                        ["logger"] = "`$ANY`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["metrics"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["paging"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["afterVar"] = "after",
                        ["cursorParam"] = "cursor",
                        ["firstVar"] = "first",
                        ["limitParam"] = "limit",
                        ["pageParam"] = "page",
                        ["startPage"] = 1,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["limit"] = "`$NUMBER`",
                        ["ops"] = "`$LIST`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["ratelimit"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["burst"] = 5,
                        ["rate"] = 5,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["retry"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["factor"] = 2,
                        ["maxDelay"] = 2000,
                        ["minDelay"] = 50,
                        ["retries"] = 2,
                        ["statuses"] = new List<object?>
                        {
                            408,
                            425,
                            429,
                            500,
                            502,
                            503,
                            504,
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["jitter"] = "`$BOOLEAN`",
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["telemetry"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["exporter"] = "`$FUNCTION`",
                        ["headers"] = "`$MAP`",
                        ["idgen"] = "`$FUNCTION`",
                        ["now"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["test"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["entity"] = "`$MAP`",
                        ["net"] = "`$MAP`",
                    },
                    ["strict"] = false,
                    ["transport"] = "base",
                },
                ["timeout"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["ms"] = 30000,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["clearTimer"] = "`$FUNCTION`",
                        ["now"] = "`$FUNCTION`",
                        ["setTimer"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
            },
            ["options"] = new Dictionary<string, object?>
            {
                ["base"] = "https://secure-cert.shieldconex.com/api",
                ["auth"] = new Dictionary<string, object?>
                {
                    ["prefix"] = "Basic",
                    ["basic"] = true,
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
                            ["title"] = "Batches",
                            ["type"] = "`$ARRAY`",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$ARRAY`",
                                },
                            },
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "bfid",
                            ["title"] = "Bfid",
                            ["type"] = "`$STRING`",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["short"] = "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "messageId",
                            ["title"] = "Message Id",
                            ["type"] = "`$STRING`",
                            ["short"] = "Message Id",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["title"] = "Name",
                            ["type"] = "`$STRING`",
                            ["short"] = "Field Name.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "reference",
                            ["title"] = "Reference",
                            ["type"] = "`$STRING`",
                            ["short"] = "Request Reference.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "value",
                            ["title"] = "Value",
                            ["type"] = "`$STRING`",
                            ["short"] = "Field Value.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "values",
                            ["title"] = "Values",
                            ["type"] = "`$ARRAY`",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$ARRAY`",
                                },
                            },
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
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/batch/detokenize",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "tokenization",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "batch",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "detokenize",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "batch",
                                        "detokenize",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/detokenize",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "tokenization",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "detokenize",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "detokenize",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
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
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/healthcheck/detokenize",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "healthcheck",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "detokenize",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "healthcheck",
                                        "detokenize",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.values`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "bfid",
                                                ["orig"] = "bfid",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                                ["reqd"] = true,
                                                ["field"] = true,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "field_name",
                                                ["orig"] = "fieldNames",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "field_value",
                                                ["orig"] = "fieldValues",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "reference",
                                                ["orig"] = "reference",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                                ["field"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "bfid",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
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
                            ["title"] = "Batches",
                            ["type"] = "`$ARRAY`",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$ARRAY`",
                                },
                            },
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "bfid",
                            ["title"] = "Bfid",
                            ["type"] = "`$STRING`",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["short"] = "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "messageId",
                            ["title"] = "Message Id",
                            ["type"] = "`$STRING`",
                            ["short"] = "Message Id",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["title"] = "Name",
                            ["type"] = "`$STRING`",
                            ["short"] = "Field Name.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "reference",
                            ["title"] = "Reference",
                            ["type"] = "`$STRING`",
                            ["short"] = "Request Reference.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "templateRef",
                            ["title"] = "Template Ref",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Template Reference",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "value",
                            ["title"] = "Value",
                            ["type"] = "`$STRING`",
                            ["short"] = "Field Value.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "values",
                            ["title"] = "Values",
                            ["type"] = "`$ARRAY`",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$ARRAY`",
                                },
                            },
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
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/batch/tokenize",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "tokenization",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "batch",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "tokenize",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "batch",
                                        "tokenize",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "omit",
                                                ["orig"] = "omit",
                                                ["type"] = "`$NUMBER`",
                                                ["kind"] = "query",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/delete",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "tokenization",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "delete",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "delete",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/tokenize",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "tokenization",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "tokenize",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "tokenize",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "omit",
                                                ["orig"] = "omit",
                                                ["type"] = "`$NUMBER`",
                                                ["kind"] = "query",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
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
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/healthcheck/tokenize",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "healthcheck",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "tokenize",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "healthcheck",
                                        "tokenize",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.values`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "field_name",
                                                ["orig"] = "fieldNames",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "field_value",
                                                ["orig"] = "fieldValues",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "reference",
                                                ["orig"] = "reference",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                                ["field"] = true,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "template_ref",
                                                ["orig"] = "templateRef",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "template_ref",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
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
                            ["title"] = "Batches",
                            ["type"] = "`$ARRAY`",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$ARRAY`",
                                },
                            },
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "messageId",
                            ["title"] = "Message Id",
                            ["type"] = "`$STRING`",
                            ["short"] = "Message Id",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "reference",
                            ["title"] = "Reference",
                            ["type"] = "`$STRING`",
                            ["short"] = "Request Reference.",
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
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/batch/delete",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "tokenization",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "batch",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "delete",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "batch",
                                        "delete",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/batch/read",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "tokenization",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "batch",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "read",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "batch",
                                        "read",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
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
                            ["title"] = "Bfid",
                            ["type"] = "`$STRING`",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["short"] = "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "messageId",
                            ["title"] = "Message Id",
                            ["type"] = "`$STRING`",
                            ["short"] = "Message Id",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "reference",
                            ["title"] = "Reference",
                            ["type"] = "`$STRING`",
                            ["short"] = "Request Reference.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "state",
                            ["title"] = "State",
                            ["type"] = "`$OBJECT`",
                            ["short"] = "Tokenized State Data (if available)",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "values",
                            ["title"] = "Values",
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
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/tokenization/read",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "tokenization",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "read",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "tokenization",
                                        "read",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
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
                            ["title"] = "Message Id",
                            ["type"] = "`$STRING`",
                            ["short"] = "Message Id",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "reference",
                            ["title"] = "Reference",
                            ["type"] = "`$STRING`",
                            ["short"] = "Request Reference.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "templateRef",
                            ["title"] = "Template Ref",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Template Reference.",
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
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/partner/validate",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "partner",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "validate",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "partner",
                                        "validate",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/template/validate",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "template",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "validate",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "template",
                                        "validate",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
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

    public static List<object?> FeaturePlugins(string name)
    {
        switch (name)
        {
            default:
                return new List<object?>();
        }
    }

    public static Feature.BaseFeature MakeFeature(string name)
    {
        switch (name)
        {
            case "audit":
                return new Feature.AuditFeature();
            case "clienttrack":
                return new Feature.ClienttrackFeature();
            case "debug":
                return new Feature.DebugFeature();
            case "idempotency":
                return new Feature.IdempotencyFeature();
            case "log":
                return new Feature.LogFeature();
            case "metrics":
                return new Feature.MetricsFeature();
            case "paging":
                return new Feature.PagingFeature();
            case "ratelimit":
                return new Feature.RatelimitFeature();
            case "retry":
                return new Feature.RetryFeature();
            case "telemetry":
                return new Feature.TelemetryFeature();
            case "test":
                return new Feature.TestFeature();
            case "timeout":
                return new Feature.TimeoutFeature();
            default:
                return new Feature.BaseFeature();
        }
    }
}
