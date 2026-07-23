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

func TestValidateEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Validate(nil)
		if ent == nil {
			t.Fatal("expected non-nil ValidateEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := validateBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "validate." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set BLUEFINSHIELDCONEX_TEST_VALIDATE_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		validateRef01Ent := client.Validate(nil)
		validateRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "validate"}, setup.data), "validate_ref01"))

		validateRef01DataResult, err := validateRef01Ent.Create(validateRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		validateRef01Data = core.ToMapAny(validateRef01DataResult)
		if validateRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}

	})
}

func validateBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "validate", "ValidateTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read validate test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse validate test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"validate01", "validate02", "validate03"},
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
	entidEnvRaw := os.Getenv("BLUEFINSHIELDCONEX_TEST_VALIDATE_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"BLUEFINSHIELDCONEX_TEST_VALIDATE_ENTID": idmap,
		"BLUEFINSHIELDCONEX_TEST_LIVE":      "FALSE",
		"BLUEFINSHIELDCONEX_TEST_EXPLAIN":   "FALSE",
		"BLUEFINSHIELDCONEX_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["BLUEFINSHIELDCONEX_TEST_VALIDATE_ENTID"])
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
