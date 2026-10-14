
const envlocal = __dirname + '/../../../.env.local'
require('../../utility').loadEnvLocal(envlocal)

const Path = require('node:path')
const Fs = require('node:fs')

const { test, describe, afterEach } = require('node:test')
const assert = require('node:assert')
const { createLiveTransport } = require('../../live-runner')
const { runLiveEntity } = require('../../live-entity')


const { BluefinShieldconexSDK, BaseFeature, stdutil, config } = require('../../..')

const {
  envOverride,
  liveClientOptions,
  liveDelay,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
} = require('../../utility')


describe('TokenizeBatchEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when BLUEFIN_SHIELDCONEX_TEST_LIVE=TRUE.
  afterEach(liveDelay('BLUEFIN_SHIELDCONEX_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = BluefinShieldconexSDK.test()
    const ent = testsdk.TokenizeBatch()
    assert(null != ent)
  })


  test('validate', async (t) => {
    if (null == config.feature?.validate) {
      t.skip('feature not present in this SDK: validate')
      return
    }
    const client = BluefinShieldconexSDK.test(undefined, { feature: { validate: { active: true } } })
    await assert.rejects(client.TokenizeBatch().create({"messageId":1}),
      (err) => 'validate_failed' === err.code)
  })



  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"batches":{"a":true,"h":"Batches","n":"batches","op":{"create":{"req":true,"type":"`$ARRAY`"}},"r":false,"t":"`$ARRAY`","key$":"batches","index$":0},"messageId":{"a":true,"h":"Message Id","n":"messageId","r":false,"sh":"Message Id","t":"`$STRING`","key$":"messageId","index$":1},"reference":{"a":true,"h":"Reference","n":"reference","r":false,"sh":"Request Reference.","t":"`$STRING`","key$":"reference","index$":2}},"name":"tokenize_batch","op":{"create":{"input":"data","name":"create","points":[{"a":true,"bf":["batches","reference"],"co":{"id":"POST /tokenization/batch/delete","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/tokenization/batch/delete","q":{},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"tokenization"},{"lit":"batch"},{"lit":"delete"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"bf":["batches","reference"],"co":{"id":"POST /tokenization/batch/read","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/tokenization/batch/read","q":{},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"tokenization"},{"lit":"batch"},{"lit":"read"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1}],"key$":"create"}},"relations":{"ancestors":[]},"key$":"tokenize_batch","name__orig":"tokenize_batch","Name":"TokenizeBatch","name_":"tokenize_batch","name-":"tokenize-batch","NAME":"TOKENIZE_BATCH","index$":2}, {"active":true,"entity":"tokenize_batch","key$":"BasicTokenizeBatchFlow","kind":"basic","name":"BasicTokenizeBatchFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"tokenize_batch_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0}]}, 'TokenizeBatch', {"POST /tokenization/batch/delete":{"protocol":"http","requestBody":{"description":"Tokenized delete batch data query.","content":{"application/json":{"schema":{"required":["batches"],"type":"object","properties":{"reference":{"type":"string","description":"Batch Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.","key$":"reference"},"batches":{"type":"array","items":{"required":["bfid"],"type":"object","properties":{"reference":{"type":"string","description":"Batch Item Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes."},"bfid":{"type":"string","description":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization."}},"description":"Data to be read and deleted","x-ref":"#/components/schemas/TokenizeDeleteBatchRequestItemData"},"key$":"batches"}},"description":"Read and delete tokenized data query","x-ref":"#/components/schemas/TokenizeDeleteBatchRequest","index$":1}}},"required":true},"parameters":[]},"POST /tokenization/batch/read":{"protocol":"http","requestBody":{"description":"Tokenized read batch data query.","content":{"application/json":{"schema":{"required":["batches"],"type":"object","properties":{"reference":{"type":"string","description":"Batch Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.","key$":"reference"},"batches":{"type":"array","items":{"required":["bfid"],"type":"object","properties":{"reference":{"type":"string","description":"Batch Item Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes."},"bfid":{"type":"string","description":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization."}},"description":"Data to be read","x-ref":"#/components/schemas/TokenizeReadBatchRequestItemData"},"key$":"batches"}},"description":"Read tokenized batch data query","x-ref":"#/components/schemas/TokenizeReadBatchRequest","index$":1}}},"required":true},"parameters":[]}}, { strict: LIVE_STRICT, t })
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const tokenize_batch_ref01_ent = client.TokenizeBatch()
    let tokenize_batch_ref01_data = setup.data.new.tokenize_batch['tokenize_batch_ref01']

    tokenize_batch_ref01_data = (await tokenize_batch_ref01_ent.create(tokenize_batch_ref01_data)).data()
    assert(null != tokenize_batch_ref01_data)


  })
})



// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const LIVE_STRICT = true

function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/tokenize_batch/TokenizeBatchTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = BluefinShieldconexSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['tokenize_batch01','tokenize_batch02','tokenize_batch03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID': idmap,
    'BLUEFIN_SHIELDCONEX_TEST_LIVE': 'FALSE',
    'BLUEFIN_SHIELDCONEX_TEST_EXPLAIN': 'FALSE',
    'BLUEFIN_SHIELDCONEX_APIKEY': '',
  })

  idmap = env['BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID']

  const live = 'TRUE' === env.BLUEFIN_SHIELDCONEX_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_BATCH_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new BluefinShieldconexSDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
        apikey: env.BLUEFIN_SHIELDCONEX_APIKEY,
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when
      // the last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey and
      // server values above and handed the SDK undefined.
      extra || {},
      { system: { fetch: transport.fetch } }
    ]))
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
  }

  return setup
}
  
