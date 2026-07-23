# Tokenize entity test

require "minitest/autorun"
require "json"
require_relative "../BluefinShieldconex_sdk"
require_relative "runner"

class TokenizeEntityTest < Minitest::Test
  def test_create_instance
    testsdk = BluefinShieldconexSDK.test(nil, nil)
    ent = testsdk.Tokenize(nil)
    assert !ent.nil?
  end

  # Feature #4: the entity stream(action, ...) method runs the op pipeline and
  # returns an Enumerator over result items. With the streaming feature active
  # it yields the feature's incremental output; otherwise it falls back to the
  # materialised list so stream always yields.
  def test_stream
    seed = {
      "entity" => {
        "tokenize" => {
          "s1" => { "id" => "s1" },
          "s2" => { "id" => "s2" },
          "s3" => { "id" => "s3" },
        },
      },
    }

    # Fallback: streaming inactive -> yields the materialised list items.
    base = BluefinShieldconexSDK.test(seed, nil)
    seen = base.Tokenize(nil).stream("list", nil, nil).to_a
    assert_equal 3, seen.length

    # Inbound: streaming active -> yields each item from the feature.
    cfg = BluefinShieldconexConfig.make_config
    if cfg["feature"].is_a?(Hash) && cfg["feature"].key?("streaming")
      sdk = BluefinShieldconexSDK.test(seed, { "feature" => { "streaming" => { "active" => true } } })
      got = []
      sdk.Tokenize(nil).stream("list", nil, nil).each do |item|
        if item.is_a?(Array)
          got.concat(item)
        else
          got << item
        end
      end
      assert_equal 3, got.length
    end
  end

  def test_basic_flow
    setup = tokenize_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["create", "list"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "tokenize." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # CREATE
    tokenize_ref01_ent = client.Tokenize(nil)
    tokenize_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.tokenize"), "tokenize_ref01"))

    tokenize_ref01_data_result = tokenize_ref01_ent.create(tokenize_ref01_data, nil)
    tokenize_ref01_data = Helpers.to_map(tokenize_ref01_data_result)
    assert !tokenize_ref01_data.nil?

    # LIST
    tokenize_ref01_match = {}

    tokenize_ref01_list_result = tokenize_ref01_ent.list(tokenize_ref01_match, nil)
    assert tokenize_ref01_list_result.is_a?(Array)

  end
end

def tokenize_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "tokenize", "TokenizeTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = BluefinShieldconexSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["tokenize01", "tokenize02", "tokenize03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID" => idmap,
    "BLUEFINSHIELDCONEX_TEST_LIVE" => "FALSE",
    "BLUEFINSHIELDCONEX_TEST_EXPLAIN" => "FALSE",
    "BLUEFINSHIELDCONEX_APIKEY" => "NONE",
  })

  idmap_resolved = Helpers.to_map(
    env["BLUEFINSHIELDCONEX_TEST_TOKENIZE_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["BLUEFINSHIELDCONEX_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
        "apikey" => env["BLUEFINSHIELDCONEX_APIKEY"],
      },
      extra || {},
    ])
    client = BluefinShieldconexSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["BLUEFINSHIELDCONEX_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["BLUEFINSHIELDCONEX_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
