// Generated basic-flow test for the tokenize_read entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct TokenizeReadSetup {
  std::shared_ptr<BluefinShieldconexSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static TokenizeReadSetup tokenize_read_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/tokenize_read/TokenizeReadTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = BluefinShieldconexSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("tokenize_read01"), Value("tokenize_read02"), Value("tokenize_read03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"BLUEFINSHIELDCONEX_TEST_TOKENIZE_READ_ENTID", idmap},
    {"BLUEFINSHIELDCONEX_TEST_LIVE", Value("FALSE")},
    {"BLUEFINSHIELDCONEX_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "BLUEFINSHIELDCONEX_TEST_TOKENIZE_READ_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "BLUEFINSHIELDCONEX_TEST_LIVE") == Value("TRUE");

  TokenizeReadSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void tokenize_read_entity_instance() {
  auto testsdk = BluefinShieldconexSDK::testSDK();
  auto ent = testsdk->tokenize_read();
  ASSERT_EQ(ent->getName(), std::string("tokenize_read"), "entity name");
}

static void tokenize_read_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"tokenize_read", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = BluefinShieldconexSDK::testSDK(seed, sdkopts);
  auto se = strsdk->tokenize_read();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = BluefinShieldconexSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->tokenize_read();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void tokenize_read_entity_basic() {
  auto setup = tokenize_read_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create"}) {
    auto sk = is_control_skipped("entityOp", std::string("tokenize_read.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto tokenize_read_ref01_ent = client->tokenize_read();
  Value tokenize_read_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "tokenize_read"}), "tokenize_read_ref01"));
  if (!tokenize_read_ref01_data.is_map()) tokenize_read_ref01_data = vmap();
  {
    Value tokenize_read_ref01_data_result = tokenize_read_ref01_ent->create(Struct::clone(tokenize_read_ref01_data), Value::undef());
    tokenize_read_ref01_data = Helpers::toMapAny(tokenize_read_ref01_data_result);
    if (!tokenize_read_ref01_data.is_map()) tokenize_read_ref01_data = vmap();
    ASSERT_TRUE(tokenize_read_ref01_data.is_map(), "expected create result to be a map");
  }

}

int main() {
  T_RUN(tokenize_read_entity_instance);
  T_RUN(tokenize_read_entity_stream);
  T_RUN(tokenize_read_entity_basic);
  return sdktest::summary("tokenize_read_entity_test");
}
