-- TokenizeBatch entity test

local json = require("dkjson")
local vs = require("utility.struct.struct")
local sdk = require("bluefin-shieldconex_sdk")
local helpers = require("core.helpers")
local runner = require("test.runner")

local _test_dir = debug.getinfo(1, "S").source:match("^@(.+/)")  or "./"

describe("TokenizeBatchEntity", function()
  it("should create instance", function()
    local testsdk = sdk.test(nil, nil)
    local ent = testsdk:TokenizeBatch(nil)
    assert.is_not_nil(ent)
  end)

  it("should run basic flow", function()
    local setup = tokenize_batch_basic_setup(nil)
    -- Per-op sdk-test-control.json skip.
    local _live = setup.live or false
    for _, _op in ipairs({"create"}) do
      local _should_skip, _reason = runner.is_control_skipped("entityOp", "tokenize_batch." .. _op, _live and "live" or "unit")
      if _should_skip then
        pending(_reason or "skipped via sdk-test-control.json")
        return
      end
    end
    -- The basic flow consumes synthetic IDs from the fixture. In live mode
    -- without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup.synthetic_only then
      pending("live entity test uses synthetic IDs from fixture — set BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID JSON to run live")
      return
    end
    local client = setup.client

    -- CREATE
    local tokenize_batch_ref01_ent = client:TokenizeBatch(nil)
    local tokenize_batch_ref01_data = helpers.to_map(vs.getprop(
      vs.getpath(setup.data, "new.tokenize_batch"), "tokenize_batch_ref01"))

    local tokenize_batch_ref01_data_result, err = tokenize_batch_ref01_ent:create(tokenize_batch_ref01_data, nil)
    assert.is_nil(err)
    tokenize_batch_ref01_data = helpers.to_map(tokenize_batch_ref01_data_result)
    assert.is_not_nil(tokenize_batch_ref01_data)

  end)
end)

function tokenize_batch_basic_setup(extra)
  runner.load_env_local()

  local entity_data_file = _test_dir .. "../../.sdk/test/entity/tokenize_batch/TokenizeBatchTestData.json"
  local f = io.open(entity_data_file, "r")
  if f == nil then
    error("failed to read tokenize_batch test data: " .. entity_data_file)
  end
  local entity_data_source = f:read("*a")
  f:close()

  local entity_data = json.decode(entity_data_source)

  local options = {}
  options["entity"] = entity_data["existing"]

  local client = sdk.test(options, extra)

  -- Generate idmap via transform.
  local idmap = vs.transform(
    { "tokenize_batch01", "tokenize_batch02", "tokenize_batch03" },
    {
      ["`$PACK`"] = { "", {
        ["`$KEY`"] = "`$COPY`",
        ["`$VAL`"] = { "`$FORMAT`", "upper", "`$COPY`" },
      }},
    }
  )

  -- Detect ENTID env override before envOverride consumes it. When live
  -- mode is on without a real override, the basic test runs against synthetic
  -- IDs from the fixture and 4xx's. Surface this so the test can skip.
  local entid_env_raw = os.getenv("BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID")
  local idmap_overridden = entid_env_raw ~= nil and entid_env_raw:match("^%s*{") ~= nil

  local env = runner.env_override({
    ["BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID"] = idmap,
    ["BLUEFINSHIELDCONEX_TEST_LIVE"] = "FALSE",
    ["BLUEFINSHIELDCONEX_TEST_EXPLAIN"] = "FALSE",
    ["BLUEFINSHIELDCONEX_APIKEY"] = "NONE",
  })

  local idmap_resolved = helpers.to_map(
    env["BLUEFINSHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID"])
  if idmap_resolved == nil then
    idmap_resolved = helpers.to_map(idmap)
  end

  if env["BLUEFINSHIELDCONEX_TEST_LIVE"] == "TRUE" then
    local merged_opts = vs.merge({
      {
        apikey = env["BLUEFINSHIELDCONEX_APIKEY"],
      },
      extra or {},
    })
    client = sdk.new(helpers.to_map(merged_opts))
  end

  local live = env["BLUEFINSHIELDCONEX_TEST_LIVE"] == "TRUE"
  return {
    client = client,
    data = entity_data,
    idmap = idmap_resolved,
    env = env,
    explain = env["BLUEFINSHIELDCONEX_TEST_EXPLAIN"] == "TRUE",
    live = live,
    synthetic_only = live and not idmap_overridden,
    now = os.time() * 1000,
  }
end
