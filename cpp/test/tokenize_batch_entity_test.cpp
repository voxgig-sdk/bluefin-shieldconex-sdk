// Generated basic-flow test for the tokenize_batch entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct TokenizeBatchSetup {
  std::shared_ptr<BluefinShieldconexSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static TokenizeBatchSetup tokenize_batch_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/tokenize_batch/TokenizeBatchTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = BluefinShieldconexSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("tokenize_batch01"), Value("tokenize_batch02"), Value("tokenize_batch03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID", idmap},
    {"BLUEFIN_SHIELDCONEX_TEST_LIVE", Value("FALSE")},
    {"BLUEFIN_SHIELDCONEX_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "BLUEFIN_SHIELDCONEX_TEST_LIVE") == Value("TRUE");

  TokenizeBatchSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void tokenize_batch_entity_instance() {
  auto testsdk = BluefinShieldconexSDK::testSDK();
  auto ent = testsdk->tokenize_batch();
  ASSERT_EQ(ent->getName(), std::string("tokenize_batch"), "entity name");
}


static void tokenize_batch_entity_basic() {
  auto setup = tokenize_batch_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create"}) {
    auto sk = is_control_skipped("entityOp", std::string("tokenize_batch.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto tokenize_batch_ref01_ent = client->tokenize_batch();
  Value tokenize_batch_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "tokenize_batch"}), "tokenize_batch_ref01"));
  if (!tokenize_batch_ref01_data.is_map()) tokenize_batch_ref01_data = vmap();
  {
    Value tokenize_batch_ref01_data_result = tokenize_batch_ref01_ent->create(Struct::clone(tokenize_batch_ref01_data), Value::undef())->data();
    tokenize_batch_ref01_data = Helpers::toMapAny(tokenize_batch_ref01_data_result);
    if (!tokenize_batch_ref01_data.is_map()) tokenize_batch_ref01_data = vmap();
    ASSERT_TRUE(tokenize_batch_ref01_data.is_map(), "expected create result to be a map");
  }

}

int main() {
  T_RUN(tokenize_batch_entity_instance);
  T_RUN(tokenize_batch_entity_basic);
  return sdktest::summary("tokenize_batch_entity_test");
}
