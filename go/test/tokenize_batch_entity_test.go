package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/bluefin-shieldconex-sdk/go"
	"github.com/voxgig-sdk/bluefin-shieldconex-sdk/go/core"

	vs "github.com/voxgig-sdk/bluefin-shieldconex-sdk/go/utility/struct"
)

// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const tokenize_batchEntityLiveStrict = true


func TestTokenizeBatchEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.TokenizeBatch(nil)
		if ent == nil {
			t.Fatal("expected non-nil TokenizeBatchEntity")
		}
	})

	t.Run("validate", func(t *testing.T) {
		if !fhHasFeature("validate") {
			t.Skip("feature not present in this SDK: validate")
		}
		client := sdk.TestSDK(nil, map[string]any{
			"feature": map[string]any{"validate": map[string]any{"active": true}},
		})
		_, err := client.TokenizeBatch(nil).Create(map[string]any{"messageId": 1}, nil)
		if sdkerr, ok := err.(*core.BluefinShieldconexError); !ok || "validate_failed" != sdkerr.Code {
			t.Fatalf("expected validate_failed, got %v", err)
		}
	})

	t.Run("basic", func(tt *testing.T) {
		var t testing.TB = tt
		setup := tokenize_batchBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "tokenize_batch." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		client := setup.client
		_ = client

		// CREATE
		tokenizeBatchRef01Ent := client.TokenizeBatch(nil)
		tokenizeBatchRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath(setup.data, []any{"new", "tokenize_batch"}), "tokenize_batch_ref01"))

		tokenizeBatchRef01DataResult, err := tokenizeBatchRef01Ent.Create(tokenizeBatchRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		tokenizeBatchRef01Data = core.ToMapAny(entityData(tokenizeBatchRef01DataResult))
		if tokenizeBatchRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}

	})
}

func tokenize_batchBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "tokenize_batch", "TokenizeBatchTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read tokenize_batch test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse tokenize_batch test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap, _ := vs.Transform(
		[]any{"tokenize_batch01", "tokenize_batch02", "tokenize_batch03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Whether *_ENTID supplied the idmap, read before envOverride consumes it:
	// without it, the ids a live flow binds are the fixture's synthetic ones.
	entidEnvRaw := os.Getenv("BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID": idmap,
		"BLUEFIN_SHIELDCONEX_TEST_LIVE":      "FALSE",
		"BLUEFIN_SHIELDCONEX_TEST_EXPLAIN":   "FALSE",
		"BLUEFIN_SHIELDCONEX_APIKEY":         "",
	})

	idmapResolved := core.ToMapAny(env["BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["BLUEFIN_SHIELDCONEX_TEST_LIVE"] == "TRUE" {
		// An empty map, not a nil one: Merge returns nil when its last entry
		// is nil, and BasicSetup is normally called with no extras - so a
		// bare nil silently discarded the apikey and server values below.
		extraOpts := extra
		if extraOpts == nil {
			extraOpts = map[string]any{}
		}

		mergedOpts := vs.Merge([]any{
			// liveClientOptions() FIRST, so the generated fields below win:
			// sdk-test-control.json's test.client.options adds to the live
			// client, it does not redirect it.
			liveClientOptions(),
			map[string]any{
				"apikey": env["BLUEFIN_SHIELDCONEX_APIKEY"],
			},
			extraOpts,
		})
		client = sdk.NewBluefinShieldconexSDK(core.ToMapAny(mergedOpts))
	}

	live := env["BLUEFIN_SHIELDCONEX_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["BLUEFIN_SHIELDCONEX_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
