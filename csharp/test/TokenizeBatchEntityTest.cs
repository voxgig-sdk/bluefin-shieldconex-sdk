// tokenize_batch entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace BluefinShieldconexSdk.Test;

public class TokenizeBatchEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = BluefinShieldconexSDK.TestSDK(null, null);
        var ent = testsdk.TokenizeBatch();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = TokenizeBatchBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "tokenize_batch." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // CREATE
        var tokenizeBatchRef01Ent = client.TokenizeBatch();
        var tokenizeBatchRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "tokenize_batch")),
            "tokenize_batch_ref01"));

        var tokenizeBatchRef01DataResult = tokenizeBatchRef01Ent.Create(tokenizeBatchRef01Data, null);
        tokenizeBatchRef01Data = Helpers.ToMapAny(tokenizeBatchRef01DataResult);
        Assert.True(tokenizeBatchRef01Data != null, "expected create result to be a map");

    }

    private static EntityTestSetup TokenizeBatchBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "tokenize_batch",
            "TokenizeBatchTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse tokenize_batch test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = BluefinShieldconexSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "tokenize_batch01", "tokenize_batch02", "tokenize_batch03" },
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
            "BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID"] = idmap,
            ["BLUEFINSHIELDCONEX_TEST_LIVE"] = "FALSE",
            ["BLUEFINSHIELDCONEX_TEST_EXPLAIN"] = "FALSE",
            ["BLUEFINSHIELDCONEX_APIKEY"] = "NONE",
        });

        var idmapResolved = Helpers.ToMapAny(env["BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID"])
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
