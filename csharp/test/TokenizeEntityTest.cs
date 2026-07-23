// tokenize entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace BluefinShieldconexSdk.Test;

public class TokenizeEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = BluefinShieldconexSDK.TestSDK(null, null);
        var ent = testsdk.Tokenize();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = TokenizeBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "list" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "tokenize." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // CREATE
        var tokenizeRef01Ent = client.Tokenize();
        var tokenizeRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "tokenize")),
            "tokenize_ref01"));

        var tokenizeRef01DataResult = tokenizeRef01Ent.Create(tokenizeRef01Data, null);
        tokenizeRef01Data = Helpers.ToMapAny(tokenizeRef01DataResult);
        Assert.True(tokenizeRef01Data != null, "expected create result to be a map");

        // LIST
        var tokenizeRef01Match = new Dictionary<string, object?>();

        var tokenizeRef01ListResult = tokenizeRef01Ent.List(tokenizeRef01Match, null);
        var tokenizeRef01List = tokenizeRef01ListResult as List<object?>;
        Assert.True(tokenizeRef01List != null,
            $"expected list result to be a list, got {tokenizeRef01ListResult?.GetType()}");

        var tokenizeRef01ListFound = StructUtils.Select(
            TestRunner.EntityListToData(tokenizeRef01List!),
            new Dictionary<string, object?> { ["id"] = tokenizeRef01Data!["id"] });
        Assert.False(StructUtils.IsEmpty(tokenizeRef01ListFound),
            "expected to find created entity in list");

    }

    [Fact]
    public async Task Stream()
    {
        var setup = TokenizeBasicSetup(new Dictionary<string, object?>
        {
            ["feature"] = new Dictionary<string, object?>
            {
                ["streaming"] = new Dictionary<string, object?> { ["active"] = true },
            },
        });
        if (setup.Live)
        {
            return; // unit mode only - streams the seeded fixture data
        }

        var ent = setup.Client.Tokenize();
        var match = new Dictionary<string, object?>();

        // Materialised list result for the same op.
        var listed = ent.List(match, null) as List<object?> ?? new List<object?>();

        // stream("list") yields items via the streaming feature's iterator.
        var streamed = new List<object?>();
        await foreach (var item in ent.Stream("list", match, null))
        {
            streamed.Add(item);
        }
        Assert.True(streamed.Count > 0, "expected stream to yield items");
        Assert.Equal(listed.Count, streamed.Count);

        // Fallback: with streaming inactive, stream still yields the
        // materialised items.
        var setup2 = TokenizeBasicSetup(null);
        var ent2 = setup2.Client.Tokenize();
        var streamed2 = new List<object?>();
        await foreach (var item in ent2.Stream("list", match, null))
        {
            streamed2.Add(item);
        }
        Assert.Equal(listed.Count, streamed2.Count);
    }

    private static EntityTestSetup TokenizeBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "tokenize",
            "TokenizeTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse tokenize test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = BluefinShieldconexSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "tokenize01", "tokenize02", "tokenize03" },
            new Dictionary<string, object?>
            {
                ["`$PACK`"] = new List<object?>
                {
                    "",
                    new Dictionary<string, object?>
                    {
                        ["`$KEY`"] = "`$COPY`",
                        ["`$VAL`"] = new List<object?> { "`$FORMAT`", "upper", "`$COPY`" },
                    },
                },
            });

        // Detect ENTID env override before EnvOverride consumes it. When
        // live mode is on without a real override, the basic test runs
        // against synthetic IDs from the fixture and 4xx's.
        var entidEnvRaw = Environment.GetEnvironmentVariable(
            "BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID"] = idmap,
            ["BLUEFINSHIELDCONEX_TEST_LIVE"] = "FALSE",
            ["BLUEFINSHIELDCONEX_TEST_EXPLAIN"] = "FALSE",
            ["BLUEFINSHIELDCONEX_APIKEY"] = "NONE",
        });

        var idmapResolved = Helpers.ToMapAny(env["BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID"])
            ?? Helpers.ToMapAny(idmap)
            ?? new Dictionary<string, object?>();

        if (Equals(env["BLUEFINSHIELDCONEX_TEST_LIVE"], "TRUE"))
        {
            var mergedOpts = StructUtils.Merge(new List<object?>
            {
                new Dictionary<string, object?>
                {
                    ["apikey"] = env["BLUEFINSHIELDCONEX_APIKEY"],
                },
                extra,
            });
            client = new BluefinShieldconexSDK(Helpers.ToMapAny(mergedOpts));
        }

        var live = Equals(env["BLUEFINSHIELDCONEX_TEST_LIVE"], "TRUE");
        return new EntityTestSetup
        {
            Client = client,
            Data = entityData,
            Idmap = idmapResolved,
            Env = env,
            Explain = Equals(env["BLUEFINSHIELDCONEX_TEST_EXPLAIN"], "TRUE"),
            Live = live,
            SyntheticOnly = live && !idmapOverridden,
            Now = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds(),
        };
    }
}
