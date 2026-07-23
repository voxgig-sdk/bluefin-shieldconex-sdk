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

func TestDetokenizeEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Detokenize(nil)
		if ent == nil {
			t.Fatal("expected non-nil DetokenizeEntity")
		}
	})

	// Feature #4: the entity Stream(action, ...) method runs the op pipeline and
	// returns a channel over result items. With the streaming feature active it
	// yields the feature's incremental output; otherwise it falls back to the
	// materialised list so Stream always yields.
	t.Run("stream", func(t *testing.T) {
		seed := map[string]any{
			"entity": map[string]any{
				"detokenize": map[string]any{
					"s1": map[string]any{"id": "s1"},
					"s2": map[string]any{"id": "s2"},
					"s3": map[string]any{"id": "s3"},
				},
			},
		}

		// Fallback: streaming inactive -> yields the materialised list items.
		base := sdk.TestSDK(seed, nil)
		var seen []any
		for item := range base.Detokenize(nil).Stream("list", nil, nil) {
			seen = append(seen, item)
		}
		if len(seen) != 3 {
			t.Fatalf("expected 3 streamed items, got %d", len(seen))
		}

		// Inbound: streaming active -> yields each item from the feature iterator.
		hasStreaming := false
		if fm, ok := core.MakeConfig()["feature"].(map[string]any); ok {
			_, hasStreaming = fm["streaming"]
		}
		if hasStreaming {
			streamSdk := sdk.TestSDK(seed, map[string]any{
				"feature": map[string]any{"streaming": map[string]any{"active": true}},
			})
			var got []any
			for item := range streamSdk.Detokenize(nil).Stream("list", nil, nil) {
				if sub, ok := item.([]any); ok {
					got = append(got, sub...)
				} else {
					got = append(got, item)
				}
			}
			if len(got) != 3 {
				t.Fatalf("expected 3 items via streaming feature, got %d", len(got))
			}
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := detokenizeBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "detokenize." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		detokenizeRef01Ent := client.Detokenize(nil)
		detokenizeRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "detokenize"}, setup.data), "detokenize_ref01"))

		detokenizeRef01DataResult, err := detokenizeRef01Ent.Create(detokenizeRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		detokenizeRef01Data = core.ToMapAny(detokenizeRef01DataResult)
		if detokenizeRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}

		// LIST
		detokenizeRef01Match := map[string]any{}

		detokenizeRef01ListResult, err := detokenizeRef01Ent.List(detokenizeRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, detokenizeRef01ListOk := detokenizeRef01ListResult.([]any)
		if !detokenizeRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", detokenizeRef01ListResult)
		}

	})
}

func detokenizeBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "detokenize", "DetokenizeTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read detokenize test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse detokenize test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"detokenize01", "detokenize02", "detokenize03"},
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
	entidEnvRaw := os.Getenv("BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID": idmap,
		"BLUEFINSHIELDCONEX_TEST_LIVE":      "FALSE",
		"BLUEFINSHIELDCONEX_TEST_EXPLAIN":   "FALSE",
		"BLUEFINSHIELDCONEX_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID"])
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
