// Generated basic-flow test for the detokenize entity (model-driven;
// mirrors the go TestEntity generator).

#![allow(unused_variables, unused_mut, unused_imports)]

mod common;

use std::rc::Rc;

use common::*;

use bluefin_shieldconex_sdk::core::helpers::{getp, getpath, ja, jo, now_ms, setp, to_map};
use bluefin_shieldconex_sdk::utility::voxgigstruct as vs;
use bluefin_shieldconex_sdk::{test_sdk, Entity, BluefinShieldconexEntity, BluefinShieldconexSDK, Value};

#[test]
fn detokenize_entity_instance() {
    let testsdk = test_sdk(Value::Noval, Value::Noval);
    let ent = testsdk.detokenize(Value::Noval);
    assert_eq!(ent.get_name(), "detokenize");
}

#[test]
fn detokenize_entity_stream() {
    // stream() runs the list op through the full pipeline and yields each
    // result item. Seed two entities via test mode; with the `streaming`
    // feature active it yields the feature's incremental items, else it
    // falls back to the materialised items — either way every item yields.
    let seed = jo(vec![(
        "entity",
        jo(vec![(
            "detokenize",
            jo(vec![
                ("strm01", jo(vec![("id", Value::str("strm01"))])),
                ("strm02", jo(vec![("id", Value::str("strm02"))])),
            ]),
        )]),
    )]);

    let sdkopts = jo(vec![(
        "feature",
        jo(vec![("streaming", jo(vec![("active", Value::Bool(true))]))]),
    )]);

    let testsdk = test_sdk(seed.clone(), sdkopts);
    let ent = testsdk.detokenize(Value::Noval);
    let items: Vec<Value> = ent
        .stream("list", Value::empty_map(), Value::empty_map())
        .expect("stream failed")
        .collect();
    assert_eq!(items.len(), 2, "stream should yield both seeded items");

    // Fallback: streaming inactive still yields both materialised items.
    let plainsdk = test_sdk(seed, Value::Noval);
    let plainent = plainsdk.detokenize(Value::Noval);
    let plain_items: Vec<Value> = plainent
        .stream("list", Value::empty_map(), Value::empty_map())
        .expect("stream failed")
        .collect();
    assert_eq!(plain_items.len(), 2, "fallback stream should yield both items");
}

#[test]
fn detokenize_entity_basic() {
    let setup = detokenize_basic_setup(Value::Noval);
    // Per-op sdk-test-control.json skip — the basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    let mode = if setup.live { "live" } else { "unit" };
    for op in ["create", "list"] {
        let (skip, reason) = is_control_skipped("entityOp", &format!("detokenize.{}", op), mode);
        if skip {
            let reason = if reason.is_empty() {
                "skipped via sdk-test-control.json".to_string()
            } else {
                reason
            };
            eprintln!("skip: {}", reason);
            return;
        }
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup.synthetic_only {
        eprintln!("skip: live entity test uses synthetic IDs from fixture — set BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID JSON to run live");
        return;
    }
    let client = setup.client.clone();
    // CREATE
    let detokenize_ref01_ent = client.detokenize(Value::Noval);
    let detokenize_ref01_data = to_map(&getp(
        &getpath(&["new", "detokenize"], &setup.data),
        "detokenize_ref01",
    ));

    let detokenize_ref01_data_result = detokenize_ref01_ent
        .create(detokenize_ref01_data.clone(), Value::Noval)
        .expect("create failed");
    let detokenize_ref01_data = to_map(&detokenize_ref01_data_result);
    assert!(
        matches!(detokenize_ref01_data, Value::Map(_)),
        "expected create result to be a map"
    );

    // LIST
    let detokenize_ref01_match = Value::empty_map();

    let detokenize_ref01_list = detokenize_ref01_ent
        .list(detokenize_ref01_match.clone(), Value::Noval)
        .expect("list failed");
    assert!(
        matches!(detokenize_ref01_list, Value::List(_)),
        "expected list result to be an array"
    );

    let found_item = vs::select(
        &entity_list_to_data(&detokenize_ref01_list),
        &jo(vec![("id", getp(&detokenize_ref01_data, "id"))]),
    );
    assert!(
        !vs::is_empty(&found_item),
        "expected to find created entity in list"
    );

}

fn detokenize_basic_setup(extra: Value) -> EntityTestSetup {
    load_env_local();

    let mut entity_data_file = manifest_dir();
    entity_data_file.push("..");
    entity_data_file.push(".sdk");
    entity_data_file.push("test");
    entity_data_file.push("entity");
    entity_data_file.push("detokenize");
    entity_data_file.push("DetokenizeTestData.json");

    let entity_data = read_json(&entity_data_file);

    let options = jo(vec![("entity", getp(&entity_data, "existing"))]);

    let client = test_sdk(options, extra.clone());

    // Generate idmap via transform, matching the TS pattern.
    let idmap = vs::transform(
        &ja(vec![Value::str("detokenize01"), Value::str("detokenize02"), Value::str("detokenize03")]),
        &jo(vec![(
            "`$PACK`",
            ja(vec![
                Value::str(""),
                jo(vec![
                    ("`$KEY`", Value::str("`$COPY`")),
                    (
                        "`$VAL`",
                        ja(vec![
                            Value::str("`$FORMAT`"),
                            Value::str("upper"),
                            Value::str("`$COPY`"),
                        ]),
                    ),
                ]),
            ]),
        )]),
        None,
    )
    .unwrap_or_else(|_| Value::empty_map());

    // Detect ENTID env override before env_override consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's.
    let entid_env_raw = std::env::var("BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID").unwrap_or_default();
    let idmap_overridden =
        !entid_env_raw.trim().is_empty() && entid_env_raw.trim().starts_with('{');

    let env = env_override(jo(vec![
        ("BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID", idmap.clone()),
        ("BLUEFINSHIELDCONEX_TEST_LIVE", Value::str("FALSE")),
        ("BLUEFINSHIELDCONEX_TEST_EXPLAIN", Value::str("FALSE")),
        ("BLUEFINSHIELDCONEX_APIKEY", Value::str("NONE")),
    ]));

    let idmap_resolved = match to_map(&getp(&env, "BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID")) {
        Value::Map(m) => Value::Map(m),
        _ => to_map(&idmap),
    };

    let live = getp(&env, "BLUEFINSHIELDCONEX_TEST_LIVE") == Value::str("TRUE");

    let client = if live {
        let merged = vs::merge(
            &ja(vec![jo(vec![("apikey", getp(&env, "BLUEFINSHIELDCONEX_APIKEY"))]), extra]),
            None,
        );
        BluefinShieldconexSDK::new(to_map(&merged))
    } else {
        client
    };

    EntityTestSetup {
        client,
        data: entity_data,
        idmap: idmap_resolved,
        env: env.clone(),
        explain: getp(&env, "BLUEFINSHIELDCONEX_TEST_EXPLAIN") == Value::str("TRUE"),
        live,
        synthetic_only: live && !idmap_overridden,
        now: now_ms(),
    }
}
