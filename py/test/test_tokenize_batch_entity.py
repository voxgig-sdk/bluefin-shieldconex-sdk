# TokenizeBatch entity test

import json
import os
import time

import pytest

from bluefinshieldconex_sdk.utility.voxgig_struct import voxgig_struct as vs
from bluefinshieldconex_sdk import BluefinShieldconexSDK
from bluefinshieldconex_sdk.core import helpers
from bluefinshieldconex_sdk.config import shared_config
from bluefinshieldconex_sdk.feature.base_feature import BluefinShieldconexBaseFeature

_TEST_DIR = os.path.dirname(os.path.abspath(__file__))
from test import runner



# main.kit.test.live.strict is true (the default is true): a live
# request that fails, or a live test missing an input it needs,
# fails the test.
# An account with no record for a test to read skips it either way.
LIVE_STRICT = True


class TestTokenizeBatchEntity:

    def test_should_create_instance(self):
        testsdk = BluefinShieldconexSDK.test(None, None)
        ent = testsdk.TokenizeBatch(None)
        assert ent is not None

    def test_should_refuse_an_invalid_request(self):
        if "validate" not in (shared_config().get("feature") or {}):
            pytest.skip("feature not present in this SDK: validate")
        client = BluefinShieldconexSDK.test(
            None, {"feature": {"validate": {"active": True}}})
        with pytest.raises(Exception) as err:
            client.TokenizeBatch(None).create({"messageId": 1}, None)
        assert "validate_failed" == getattr(err.value, "code", None)

    def test_should_run_basic_flow(self):
        setup = _tokenize_batch_basic_setup(None)
        # Per-op sdk-test-control.json skip — basic test exercises a flow with
        # multiple ops; skipping any one skips the whole flow (steps depend
        # on each other).
        _live = setup.get("live", False)
        for _op in ["create"]:
            _skip, _reason = runner.is_control_skipped("entityOp", "tokenize_batch." + _op, "live" if _live else "unit")
            if _skip:
                pytest.skip(_reason or "skipped via sdk-test-control.json")
                return
        client = setup["client"]

        # CREATE
        tokenize_batch_ref01_ent = client.TokenizeBatch(None)
        tokenize_batch_ref01_data = helpers.to_map(vs.getprop(
            vs.getpath(setup["data"], "new.tokenize_batch"), "tokenize_batch_ref01"))

        tokenize_batch_ref01_data = helpers.to_map(runner.entity_data(tokenize_batch_ref01_ent.create(tokenize_batch_ref01_data, None)))
        assert tokenize_batch_ref01_data is not None



def _tokenize_batch_basic_setup(extra):
    runner.load_env_local()

    entity_data_file = os.path.join(_TEST_DIR, "../../.sdk/test/entity/tokenize_batch/TokenizeBatchTestData.json")
    with open(entity_data_file, "r", encoding="utf-8") as f:
        entity_data_source = f.read()

    entity_data = json.loads(entity_data_source)

    options = {}
    options["entity"] = entity_data.get("existing")

    client = BluefinShieldconexSDK.test(options, extra)

    # Generate idmap via transform.
    idmap = vs.transform(
        ["tokenize_batch01", "tokenize_batch02", "tokenize_batch03"],
        {
            "`$PACK`": ["", {
                "`$KEY`": "`$COPY`",
                "`$VAL`": ["`$FORMAT`", "upper", "`$COPY`"],
            }],
        }
    )

    # Whether *_ENTID supplied the idmap, read before env_override consumes
    # it: without it, the ids a live flow binds are the fixture's synthetic ones.
    _entid_env_raw = os.environ.get(
        "BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID")
    _idmap_overridden = _entid_env_raw is not None and _entid_env_raw.strip().startswith("{")

    env = runner.env_override({
        "BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID": idmap,
        "BLUEFIN_SHIELDCONEX_TEST_LIVE": "FALSE",
        "BLUEFIN_SHIELDCONEX_TEST_EXPLAIN": "FALSE",
        "BLUEFIN_SHIELDCONEX_APIKEY": "",
    })

    idmap_resolved = helpers.to_map(
        env.get("BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID"))
    if idmap_resolved is None:
        idmap_resolved = helpers.to_map(idmap)

    if env.get("BLUEFIN_SHIELDCONEX_TEST_LIVE") == "TRUE":
        merged_opts = vs.merge([
            # FIRST, so the generated fields below win: sdk-test-control.json's
            # test.client.options adds to the live client, it does not
            # redirect it.
            runner.live_client_options(),
            {
                "apikey": env.get("BLUEFIN_SHIELDCONEX_APIKEY"),
            },
            extra or {},
        ])
        client = BluefinShieldconexSDK(helpers.to_map(merged_opts))

    _live = env.get("BLUEFIN_SHIELDCONEX_TEST_LIVE") == "TRUE"
    return {
        "client": client,
        "data": entity_data,
        "idmap": idmap_resolved,
        "env": env,
        "explain": env.get("BLUEFIN_SHIELDCONEX_TEST_EXPLAIN") == "TRUE",
        "live": _live,
        "synthetic_only": _live and not _idmap_overridden,
        "now": int(time.time() * 1000),
    }
