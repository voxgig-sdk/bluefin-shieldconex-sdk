// detokenize entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace BluefinShieldconexSdk.Test;

public class DetokenizeEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = BluefinShieldconexSDK.TestSDK(null, null);
        var ent = testsdk.Detokenize();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = DetokenizeBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "list" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "detokenize." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // CREATE
        var detokenizeRef01Ent = client.Detokenize();
        var detokenizeRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "detokenize")),
            "detokenize_ref01"));

        var detokenizeRef01DataResult = detokenizeRef01Ent.Create(detokenizeRef01Data, null);
        detokenizeRef01Data = Helpers.ToMapAny(detokenizeRef01DataResult);
        Assert.True(detokenizeRef01Data != null, "expected create result to be a map");

        // LIST
        var detokenizeRef01Match = new Dictionary<string, object?>();

        var detokenizeRef01ListResult = detokenizeRef01Ent.List(detokenizeRef01Match, null);
        var detokenizeRef01List = detokenizeRef01ListResult as List<object?>;
        Assert.True(detokenizeRef01List != null,
            $"expected list result to be a list, got {detokenizeRef01ListResult?.GetType()}");

        var detokenizeRef01ListFound = StructUtils.Select(
            TestRunner.EntityListToData(detokenizeRef01List!),
            new Dictionary<string, object?> { ["id"] = detokenizeRef01Data!["id"] });
        Assert.False(StructUtils.IsEmpty(detokenizeRef01ListFound),
            "expected to find created entity in list");

    }

    [Fact]
    public async Task Stream()
    {
        var setup = DetokenizeBasicSetup(new Dictionary<string, object?>
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

        var ent = setup.Client.Detokenize();
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
        var setup2 = DetokenizeBasicSetup(null);
        var ent2 = setup2.Client.Detokenize();
        var streamed2 = new List<object?>();
        await foreach (var item in ent2.Stream("list", match, null))
        {
            streamed2.Add(item);
        }
        Assert.Equal(listed.Count, streamed2.Count);
    }

    private static EntityTestSetup DetokenizeBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "detokenize",
            "DetokenizeTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse detokenize test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = BluefinShieldconexSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "detokenize01", "detokenize02", "detokenize03" },
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
            "BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID"] = idmap,
            ["BLUEFINSHIELDCONEX_TEST_LIVE"] = "FALSE",
            ["BLUEFINSHIELDCONEX_TEST_EXPLAIN"] = "FALSE",
            ["BLUEFINSHIELDCONEX_APIKEY"] = "NONE",
        });

        var idmapResolved = Helpers.ToMapAny(env["BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID"])
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
