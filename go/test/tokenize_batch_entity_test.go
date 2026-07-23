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

func TestTokenizeBatchEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.TokenizeBatch(nil)
		if ent == nil {
			t.Fatal("expected non-nil TokenizeBatchEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
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
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		tokenizeBatchRef01Ent := client.TokenizeBatch(nil)
		tokenizeBatchRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "tokenize_batch"}, setup.data), "tokenize_batch_ref01"))

		tokenizeBatchRef01DataResult, err := tokenizeBatchRef01Ent.Create(tokenizeBatchRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		tokenizeBatchRef01Data = core.ToMapAny(tokenizeBatchRef01DataResult)
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
	idmap := vs.Transform(
		[]any{"tokenize_batch01", "tokenize_batch02", "tokenize_batch03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID": idmap,
		"BLUEFINSHIELDCONEX_TEST_LIVE":      "FALSE",
		"BLUEFINSHIELDCONEX_TEST_EXPLAIN":   "FALSE",
		"BLUEFINSHIELDCONEX_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["BLUEFINSHIELDCONEX_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["BLUEFINSHIELDCONEX_APIKEY"],
			},
			extra,
		})
		client = sdk.NewBluefinShieldconexSDK(core.ToMapAny(mergedOpts))
	}

	live := env["BLUEFINSHIELDCONEX_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["BLUEFINSHIELDCONEX_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
