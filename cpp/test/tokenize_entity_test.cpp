// Generated basic-flow test for the tokenize entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct TokenizeSetup {
  std::shared_ptr<BluefinShieldconexSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static TokenizeSetup tokenize_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/tokenize/TokenizeTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = BluefinShieldconexSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("tokenize01"), Value("tokenize02"), Value("tokenize03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_ENTID", idmap},
    {"BLUEFIN_SHIELDCONEX_TEST_LIVE", Value("FALSE")},
    {"BLUEFIN_SHIELDCONEX_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "BLUEFIN_SHIELDCONEX_TEST_LIVE") == Value("TRUE");

  TokenizeSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void tokenize_entity_instance() {
  auto testsdk = BluefinShieldconexSDK::testSDK();
  auto ent = testsdk->tokenize();
  ASSERT_EQ(ent->getName(), std::string("tokenize"), "entity name");
}


static void tokenize_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"tokenize", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = BluefinShieldconexSDK::testSDK(seed, sdkopts);
  auto se = strsdk->tokenize();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = BluefinShieldconexSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->tokenize();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static bool tokenize_has_feature(const std::string& name) {
  Value fm = Helpers::toMapAny(getp(sharedConfig(), "feature"));
  return fm.is_map() && !getp(fm, name).is_undef();
}

class TokenizeFailHook : public BaseFeature {
public:
  int unexpected = 0;
  TokenizeFailHook() : BaseFeature("failhook", "0.0.1", true) {}
  void preSpec(CtxPtr ctx) override {
    throw std::runtime_error("tokenize hook failed");
  }
  void preUnexpected(CtxPtr ctx) override {
    unexpected++;
  }
};

static void tokenize_entity_stream_error() {
  Value offline = vmap({{"net", vmap({{"offline", Value(true)}})}});
  std::string msg;
  try {
    BluefinShieldconexSDK::testSDK(offline, Value::undef())->tokenize()
        ->stream("list", Value::undef(), Value::undef());
  } catch (const SdkErrorPtr& err) {
    msg = err->getMessage();
  }
  ASSERT_TRUE(msg.find("offline") != std::string::npos,
      "stream: a failed operation fails the stream");

  bool raised = false;
  try {
    BluefinShieldconexSDK::testSDK(offline, Value::undef())->tokenize()
        ->stream("list", Value::undef(), vmap({{"ctrl", vmap({{"throw", Value(false)}})}}));
  } catch (const SdkErrorPtr&) {
    raised = true;
  }
  ASSERT_FALSE(raised, "stream: under throw false a failed stream ends");

  if (tokenize_has_feature("rbac")) {
    std::string code;
    try {
      BluefinShieldconexSDK::testSDK(Value::undef(), vmap({{"feature", vmap({{"rbac",
          vmap({{"active", Value(true)}, {"deny", Value(true)}})}})}}))->tokenize()
          ->stream("list", Value::undef(), Value::undef());
    } catch (const SdkErrorPtr& err) {
      code = err->code;
    }
    ASSERT_EQ(code, std::string("rbac_denied"), "stream: a denied operation fails the stream");
  }
}

static void tokenize_entity_stream_ctrl() {
  Value explain = vmap();
  Value ctrl = vmap({{"explain", explain}});
  BluefinShieldconexSDK::testSDK()->tokenize()->stream("list", Value::undef(), vmap({{"ctrl", ctrl}}));
  ASSERT_TRUE(getp(ctrl, "stream").is_undef(), "stream: the caller's ctrl gains no key");
  ASSERT_TRUE(!explain.as_map()->empty(), "stream: the caller's explain record is filled");
}

static void tokenize_entity_unexpected() {
  auto hook = std::make_shared<TokenizeFailHook>();
  auto client = BluefinShieldconexSDK::testSDK();
  client->getRootCtx()->utility->featureAdd(client->getRootCtx(), hook);

  std::string msg;
  try {
    client->tokenize()->list(Value::undef(), Value::undef());
  } catch (const SdkErrorPtr& err) {
    msg = err->getMessage();
  }
  ASSERT_TRUE(msg.find("hook failed") != std::string::npos, "a throwing hook fails the operation");
  ASSERT_TRUE(0 < hook->unexpected, "a throwing hook fires PreUnexpected");

  int fired = hook->unexpected;
  client->tokenize()->list(Value::undef(), vmap({{"throw", Value(false)}}));
  ASSERT_TRUE(fired < hook->unexpected, "under throw false PreUnexpected fires too");
}

static void tokenize_entity_validate() {
  if (!tokenize_has_feature("validate")) {
    std::cerr << "skip: feature not present in this SDK: validate\n";
    return;
  }
  auto vsdk = BluefinShieldconexSDK::testSDK(Value::undef(), vmap({{"feature",
      vmap({{"validate", vmap({{"active", Value(true)}})}})}}));
  std::string code;
  try {
    vsdk->tokenize()->list(vmap({{"field_name", Value(1)}, {"template_ref", Value("x")}}), Value::undef());
  } catch (const SdkErrorPtr& err) {
    code = err->code;
  }
  ASSERT_EQ(code, std::string("validate_failed"), "an invalid request fails with validate_failed");
}

static void tokenize_entity_basic() {
  auto setup = tokenize_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "list"}) {
    auto sk = is_control_skipped("entityOp", std::string("tokenize.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto tokenize_ref01_ent = client->tokenize();
  Value tokenize_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "tokenize"}), "tokenize_ref01"));
  if (!tokenize_ref01_data.is_map()) tokenize_ref01_data = vmap();
  {
    Value tokenize_ref01_data_result = tokenize_ref01_ent->create(Struct::clone(tokenize_ref01_data), Value::undef())->data();
    tokenize_ref01_data = Helpers::toMapAny(tokenize_ref01_data_result);
    if (!tokenize_ref01_data.is_map()) tokenize_ref01_data = vmap();
    ASSERT_TRUE(tokenize_ref01_data.is_map(), "expected create result to be a map");
  }

  // LIST
  Value tokenize_ref01_match = vmap();
  auto tokenize_ref01_list_ents = tokenize_ref01_ent->list(Struct::clone(tokenize_ref01_match), Value::undef());
  // list resolves to one ENTITY per record; the flow asserts on the records.
  Value tokenize_ref01_list = vlist();
  for (const auto& e : tokenize_ref01_list_ents) { tokenize_ref01_list.as_list()->push_back(e->data()); }
  ASSERT_TRUE(tokenize_ref01_list.is_list(), "expected list result to be an array");
  {
    std::vector<Value> found = Struct::select(entity_list_to_data(tokenize_ref01_list), vmap({{"id", getp(tokenize_ref01_data, "id")}}));
    ASSERT_TRUE(!found.empty(), "expected to find created entity in list");
  }

}

int main() {
  T_RUN(tokenize_entity_instance);
  T_RUN(tokenize_entity_stream);
  T_RUN(tokenize_entity_stream_error);
  T_RUN(tokenize_entity_stream_ctrl);
  T_RUN(tokenize_entity_unexpected);
  T_RUN(tokenize_entity_validate);
  T_RUN(tokenize_entity_basic);
  return sdktest::summary("tokenize_entity_test");
}
