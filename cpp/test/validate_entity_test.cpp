// Generated basic-flow test for the validate entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct ValidateSetup {
  std::shared_ptr<BluefinShieldconexSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static ValidateSetup validate_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/validate/ValidateTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = BluefinShieldconexSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("validate01"), Value("validate02"), Value("validate03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"BLUEFINSHIELDCONEX_TEST_VALIDATE_ENTID", idmap},
    {"BLUEFINSHIELDCONEX_TEST_LIVE", Value("FALSE")},
    {"BLUEFINSHIELDCONEX_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "BLUEFINSHIELDCONEX_TEST_VALIDATE_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "BLUEFINSHIELDCONEX_TEST_LIVE") == Value("TRUE");

  ValidateSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void validate_entity_instance() {
  auto testsdk = BluefinShieldconexSDK::testSDK();
  auto ent = testsdk->validate();
  ASSERT_EQ(ent->getName(), std::string("validate"), "entity name");
}

static void validate_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"validate", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = BluefinShieldconexSDK::testSDK(seed, sdkopts);
  auto se = strsdk->validate();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = BluefinShieldconexSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->validate();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void validate_entity_basic() {
  auto setup = validate_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create"}) {
    auto sk = is_control_skipped("entityOp", std::string("validate.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto validate_ref01_ent = client->validate();
  Value validate_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "validate"}), "validate_ref01"));
  if (!validate_ref01_data.is_map()) validate_ref01_data = vmap();
  {
    Value validate_ref01_data_result = validate_ref01_ent->create(Struct::clone(validate_ref01_data), Value::undef());
    validate_ref01_data = Helpers::toMapAny(validate_ref01_data_result);
    if (!validate_ref01_data.is_map()) validate_ref01_data = vmap();
    ASSERT_TRUE(validate_ref01_data.is_map(), "expected create result to be a map");
  }

}

int main() {
  T_RUN(validate_entity_instance);
  T_RUN(validate_entity_stream);
  T_RUN(validate_entity_basic);
  return sdktest::summary("validate_entity_test");
}
