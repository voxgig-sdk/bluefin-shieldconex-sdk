"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const node_path_1 = __importDefault(require("node:path"));
const Fs = __importStar(require("node:fs"));
const node_test_1 = require("node:test");
const node_assert_1 = __importDefault(require("node:assert"));
const live_runner_1 = require("../../live-runner");
const live_entity_1 = require("../../live-entity");
const __1 = require("../../..");
const utility_1 = require("../../utility");
(0, utility_1.loadEnvLocal)(__dirname + '/../../../.env.local');
(0, node_test_1.describe)('TokenizeEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when BLUEFIN_SHIELDCONEX_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('BLUEFIN_SHIELDCONEX_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.BluefinShieldconexSDK.test();
        const ent = testsdk.Tokenize();
        (0, node_assert_1.default)(null != ent);
    });
    class FailHook extends __1.BaseFeature {
        name = 'failhook';
        version = '0.0.1';
        active = true;
        unexpected = 0;
        init() { }
        PreSpec() { throw new Error('tokenize hook failed'); }
        PreUnexpected() { this.unexpected++; }
    }
    (0, node_test_1.test)('stream-error', async () => {
        const offline = { net: { offline: true } };
        await node_assert_1.default.rejects(async () => {
            for await (const _item of __1.BluefinShieldconexSDK.test(offline).Tokenize().stream('list')) { }
        }, /offline/);
        for await (const _item of __1.BluefinShieldconexSDK.test(offline).Tokenize()
            .stream('list', undefined, { ctrl: { throw: false } })) { }
        if (null != __1.config.feature?.rbac) {
            const denied = __1.BluefinShieldconexSDK.test(undefined, { feature: { rbac: { active: true, deny: true } } });
            await node_assert_1.default.rejects(async () => {
                for await (const _item of denied.Tokenize().stream('list')) { }
            }, (err) => 'rbac_denied' === err.code);
        }
    });
    (0, node_test_1.test)('stream-ctrl', async () => {
        const explain = {};
        const ctrl = { explain };
        for await (const _item of __1.BluefinShieldconexSDK.test().Tokenize().stream('list', undefined, { ctrl })) { }
        node_assert_1.default.deepStrictEqual(Object.keys(ctrl), ['explain']);
        (0, node_assert_1.default)(explain === ctrl.explain && 0 < Object.keys(explain).length);
    });
    (0, node_test_1.test)('unexpected', async () => {
        const hook = new FailHook();
        const client = new __1.BluefinShieldconexSDK({ feature: { test: { active: true } }, extend: [hook] });
        await node_assert_1.default.rejects(client.Tokenize().list(), /hook failed/);
        (0, node_assert_1.default)(0 < hook.unexpected);
        const fired = hook.unexpected;
        node_assert_1.default.strictEqual(await client.Tokenize().list(undefined, { throw: false }), undefined);
        (0, node_assert_1.default)(fired < hook.unexpected);
    });
    (0, node_test_1.test)('validate', async (t) => {
        if (null == __1.config.feature?.validate) {
            t.skip('feature not present in this SDK: validate');
            return;
        }
        const client = __1.BluefinShieldconexSDK.test(undefined, { feature: { validate: { active: true } } });
        await node_assert_1.default.rejects(client.Tokenize().list({ "field_name": 1, "template_ref": "x" }), (err) => 'validate_failed' === err.code);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.BLUEFIN_SHIELDCONEX_TEST_LIVE;
        for (const op of ['create', 'list']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'tokenize.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": { "batches": { "a": true, "h": "Batches", "n": "batches", "op": { "create": { "req": true, "type": "`$ARRAY`" } }, "r": false, "t": "`$ARRAY`", "key$": "batches", "index$": 0 }, "bfid": { "a": true, "h": "Bfid", "n": "bfid", "op": { "create": { "req": true, "type": "`$STRING`" } }, "r": false, "sh": "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).", "t": "`$STRING`", "key$": "bfid", "index$": 1 }, "messageId": { "a": true, "h": "Message Id", "n": "messageId", "r": false, "sh": "Message Id", "t": "`$STRING`", "key$": "messageId", "index$": 2 }, "name": { "a": true, "h": "Name", "n": "name", "r": false, "sh": "Field Name.", "t": "`$STRING`", "key$": "name", "index$": 3 }, "reference": { "a": true, "h": "Reference", "n": "reference", "r": false, "sh": "Request Reference.", "t": "`$STRING`", "key$": "reference", "index$": 4 }, "templateRef": { "a": true, "h": "Template Ref", "n": "templateRef", "r": true, "sh": "Template Reference", "t": "`$STRING`", "key$": "templateRef", "index$": 5 }, "value": { "a": true, "h": "Value", "n": "value", "r": false, "sh": "Field Value.", "t": "`$STRING`", "key$": "value", "index$": 6 }, "values": { "a": true, "h": "Values", "n": "values", "op": { "create": { "req": true, "type": "`$ARRAY`" } }, "r": false, "t": "`$ARRAY`", "key$": "values", "index$": 7 } }, "name": "tokenize", "op": { "create": { "input": "data", "name": "create", "points": [{ "a": true, "bf": ["batches", "reference", "templateRef"], "co": { "id": "POST /tokenization/batch/tokenize", "source": "openapi3", "version": 2 }, "g": { "query": [{ "a": true, "k": "query", "n": "omit", "or": "omit", "r": false, "t": "`$NUMBER`", "index$": 0 }] }, "k": "http", "m": "POST", "o": "/tokenization/batch/tokenize", "q": {}, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "tokenization" }, { "lit": "batch" }, { "lit": "tokenize" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }, { "a": true, "bf": ["bfid", "reference"], "co": { "id": "POST /tokenization/delete", "source": "openapi3", "version": 2 }, "g": {}, "k": "http", "m": "POST", "o": "/tokenization/delete", "q": {}, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "tokenization" }, { "lit": "delete" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 1 }, { "a": true, "bf": ["reference", "templateRef", "values"], "co": { "id": "POST /tokenization/tokenize", "source": "openapi3", "version": 2 }, "g": { "query": [{ "a": true, "k": "query", "n": "omit", "or": "omit", "r": false, "t": "`$NUMBER`", "index$": 0 }] }, "k": "http", "m": "POST", "o": "/tokenization/tokenize", "q": {}, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "tokenization" }, { "lit": "tokenize" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 2 }], "key$": "create" }, "list": { "input": "data", "name": "list", "points": [{ "a": true, "co": { "id": "GET /healthcheck/tokenize", "source": "openapi3", "version": 2 }, "g": { "query": [{ "a": true, "k": "query", "n": "field_name", "or": "fieldNames", "r": false, "t": "`$STRING`", "index$": 0 }, { "a": true, "k": "query", "n": "field_value", "or": "fieldValues", "r": false, "t": "`$STRING`", "index$": 1 }, { "a": true, "k": "query", "n": "reference", "or": "reference", "r": false, "t": "`$STRING`", "index$": 2 }, { "a": true, "k": "query", "n": "template_ref", "or": "templateRef", "r": true, "t": "`$STRING`", "index$": 3 }] }, "k": "http", "m": "GET", "o": "/healthcheck/tokenize", "q": { "exist": ["template_ref"] }, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "healthcheck" }, { "lit": "tokenize" }], "t": { "req": "`reqdata`", "res": "`body.values`" }, "index$": 0 }], "key$": "list" } }, "relations": { "ancestors": [] }, "key$": "tokenize", "name__orig": "tokenize", "Name": "Tokenize", "name_": "tokenize", "name-": "tokenize", "NAME": "TOKENIZE", "index$": 1 }, { "active": true, "entity": "tokenize", "key$": "BasicTokenizeFlow", "kind": "basic", "name": "BasicTokenizeFlow", "param": {}, "step": [{ "a": true, "d": {}, "i": { "ref": "tokenize_ref01" }, "m": {}, "o": "create", "s": [], "v": [], "index$": 0 }, { "a": true, "d": {}, "i": {}, "m": {}, "o": "list", "s": [], "v": [{ "apply": "ItemExists", "def": { "ref": "tokenize_ref01" } }], "index$": 1 }] }, 'Tokenize', { "POST /tokenization/batch/tokenize": { "protocol": "http", "requestBody": { "description": "Data to be tokenized.", "content": { "application/json": { "schema": { "required": ["batches", "templateRef"], "type": "object", "properties": { "reference": { "type": "string", "description": "Batch Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.", "key$": "reference" }, "templateRef": { "type": "string", "description": "Template Reference", "key$": "templateRef" }, "batches": { "type": "array", "items": { "required": ["values"], "type": "object", "properties": { "reference": { "type": "string", "description": "Batch Item Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes." }, "values": { "type": "array", "items": {} } }, "description": "Batch item data to be tokenized", "x-ref": "#/components/schemas/TokenizeBatchRequestItemData" }, "key$": "batches" } }, "description": "Batch data to be tokenized", "x-ref": "#/components/schemas/TokenizeBatchRequest", "index$": 1 } } }, "required": true }, "parameters": [{ "name": "omit", "in": "query", "description": "Set this parameter to 1 if data shouldn't be present in response but can be received by separate 'read' request", "schema": { "type": "number" }, "index$": 0 }] }, "POST /tokenization/delete": { "protocol": "http", "requestBody": { "description": "Tokenized data query.", "content": { "application/json": { "schema": { "required": ["bfid"], "type": "object", "properties": { "reference": { "type": "string", "description": "Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.", "key$": "reference" }, "bfid": { "type": "string", "description": "The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.", "key$": "bfid" } }, "description": "Tokenized and detele data query", "x-ref": "#/components/schemas/TokenizeDeleteRequest", "index$": 1 } } }, "required": true }, "parameters": [] }, "POST /tokenization/tokenize": { "protocol": "http", "requestBody": { "description": "Data to be tokenized.", "content": { "application/json": { "schema": { "required": ["templateRef", "values"], "type": "object", "properties": { "reference": { "type": "string", "description": "Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.", "key$": "reference" }, "templateRef": { "type": "string", "description": "Template Reference. This is the unique alphanumeric string that is used to identify a template. The templateRef is created within ShieldConex Manager and can be found within the template details page of any template within ShieldConex Manager.", "key$": "templateRef" }, "values": { "type": "array", "items": { "type": "object", "properties": { "name": { "type": "string", "description": "Field Name. This refers to the name of a field within a template." }, "value": { "type": "string", "description": "Field Value. This is to the cleartext value that is entered into a field. This is the data that requires tokenization." } }, "description": "JSON array containing the field names (and desired values) matching the fields configured inside of the template being referenced with templateRef.", "x-ref": "#/components/schemas/TokenizeRequestItemData" }, "key$": "values" } }, "description": "Data to be tokenized", "x-ref": "#/components/schemas/TokenizeRequest", "index$": 1 } } }, "required": true }, "parameters": [{ "name": "omit", "in": "query", "description": "Set this parameter to 1 if data shouldn't be present in response but can be received by separate 'read' request. Set this parameter to 2 if data still should be present in response but also can be received by separate 'read' request. ", "schema": { "type": "number" }, "index$": 0 }] }, "GET /healthcheck/tokenize": { "protocol": "http", "parameters": [{ "name": "templateRef", "in": "query", "description": "Template Reference. This is the unique alphanumeric string that is used to identify a template. The templateRef is created within ShieldConex Manager and can be found within the template details page of any template within ShieldConex Manager.", "required": true, "schema": { "type": "string" }, "index$": 0 }, { "name": "reference", "in": "query", "description": "Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.", "schema": { "type": "string" }, "index$": 1 }, { "name": "fieldNames", "in": "query", "description": "Field names split by |. This refers to the names of the fields within a template.", "schema": { "type": "string" }, "index$": 2 }, { "name": "fieldValues", "in": "query", "description": "Field values split by |. This is the data that requires tokenization.", "schema": { "type": "string" }, "index$": 3 }] } }, { strict: LIVE_STRICT, t });
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        // CREATE
        const tokenize_ref01_ent = client.Tokenize();
        let tokenize_ref01_data = setup.data.new.tokenize['tokenize_ref01'];
        tokenize_ref01_data = (await tokenize_ref01_ent.create(tokenize_ref01_data)).data();
        (0, node_assert_1.default)(null != tokenize_ref01_data);
        // LIST
        const tokenize_ref01_match = {};
        const tokenize_ref01_list = (await tokenize_ref01_ent.list(tokenize_ref01_match)).map((e) => e.data());
    });
});
// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const LIVE_STRICT = true;
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/tokenize/TokenizeTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.BluefinShieldconexSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['tokenize01', 'tokenize02', 'tokenize03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_ENTID': idmap,
        'BLUEFIN_SHIELDCONEX_TEST_LIVE': 'FALSE',
        'BLUEFIN_SHIELDCONEX_TEST_EXPLAIN': 'FALSE',
        'BLUEFIN_SHIELDCONEX_APIKEY': '',
        'BLUEFIN_SHIELDCONEX_SECRET': '',
    });
    idmap = env['BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_ENTID'];
    const live = 'TRUE' === env.BLUEFIN_SHIELDCONEX_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_ENTID'];
        idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {};
        if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
            throw new Error('Live ENTID must be a JSON object');
        }
        client = new __1.BluefinShieldconexSDK(merge([
            // FIRST, so the generated fields below win: sdk-test-control.json's
            // test.client.options adds to the live client, it does not redirect it.
            (0, utility_1.liveClientOptions)(),
            {
                apikey: env.BLUEFIN_SHIELDCONEX_APIKEY,
                secret: env.BLUEFIN_SHIELDCONEX_SECRET,
            },
            // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
            // last entry is undefined, and basicSetup is normally called with no
            // argument at all - so a bare 'extra' silently discarded the apikey
            // and server values above and handed the SDK undefined. Harmless
            // while there was nothing in that object; not harmless now.
            extra || {},
            { system: { fetch: transport.fetch } }
        ]));
    }
    const setup = {
        idmap,
        env,
        options,
        client,
        struct,
        data: entityData,
        explain: 'TRUE' === env.BLUEFIN_SHIELDCONEX_TEST_EXPLAIN,
        live,
        transport,
        now: Date.now(),
    };
    return setup;
}
//# sourceMappingURL=TokenizeEntity.test.js.map