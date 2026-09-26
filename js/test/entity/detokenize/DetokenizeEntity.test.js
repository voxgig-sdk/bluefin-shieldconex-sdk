
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


describe('DetokenizeEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when BLUEFIN_SHIELDCONEX_TEST_LIVE=TRUE.
  afterEach(liveDelay('BLUEFIN_SHIELDCONEX_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = BluefinShieldconexSDK.test()
    const ent = testsdk.Detokenize()
    assert(null != ent)
  })


  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"batches":{"a":true,"h":"Batches","n":"batches","op":{"create":{"req":true,"type":"`$ARRAY`"}},"r":false,"t":"`$ARRAY`","key$":"batches","index$":0},"bfid":{"a":true,"h":"Bfid","n":"bfid","op":{"create":{"req":true,"type":"`$STRING`"}},"r":false,"sh":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).","t":"`$STRING`","key$":"bfid","index$":1},"messageId":{"a":true,"h":"Message Id","n":"messageId","r":false,"sh":"Message Id","t":"`$STRING`","key$":"messageId","index$":2},"name":{"a":true,"h":"Name","n":"name","r":false,"sh":"Field Name.","t":"`$STRING`","key$":"name","index$":3},"reference":{"a":true,"h":"Reference","n":"reference","r":false,"sh":"Request Reference.","t":"`$STRING`","key$":"reference","index$":4},"value":{"a":true,"h":"Value","n":"value","r":false,"sh":"Field Value.","t":"`$STRING`","key$":"value","index$":5},"values":{"a":true,"h":"Values","n":"values","op":{"create":{"req":true,"type":"`$ARRAY`"}},"r":false,"t":"`$ARRAY`","key$":"values","index$":6}},"name":"detokenize","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /tokenization/batch/detokenize","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/tokenization/batch/detokenize","q":{},"r":{},"s":[{"lit":"tokenization"},{"lit":"batch"},{"lit":"detokenize"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"POST /tokenization/detokenize","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/tokenization/detokenize","q":{},"r":{},"s":[{"lit":"tokenization"},{"lit":"detokenize"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /healthcheck/detokenize","source":"openapi3","version":2},"g":{"query":[{"a":true,"k":"query","n":"bfid","or":"bfid","r":true,"t":"`$STRING`","index$":0},{"a":true,"k":"query","n":"field_name","or":"field_name","r":false,"t":"`$STRING`","index$":1},{"a":true,"k":"query","n":"field_value","or":"field_value","r":false,"t":"`$STRING`","index$":2},{"a":true,"k":"query","n":"reference","or":"reference","r":false,"t":"`$STRING`","index$":3}]},"k":"http","m":"GET","o":"/healthcheck/detokenize","q":{"exist":["bfid","field_name","field_value","reference"]},"r":{},"s":[{"lit":"healthcheck"},{"lit":"detokenize"}],"t":{"req":"`reqdata`","res":"`body.values`"},"index$":0}],"key$":"list"}},"relations":{"ancestors":[]},"key$":"detokenize","name__orig":"detokenize","Name":"Detokenize","name_":"detokenize","name-":"detokenize","NAME":"DETOKENIZE","index$":0}, {"active":true,"entity":"detokenize","key$":"BasicDetokenizeFlow","kind":"basic","name":"BasicDetokenizeFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"detokenize_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"detokenize_ref01"}}],"index$":1}]}, 'Detokenize', {"POST /tokenization/batch/detokenize":{"protocol":"http","requestBody":{"description":"Batch data to be detokenized.","content":{"application/json":{"schema":{"required":["batches"],"type":"object","properties":{"reference":{"type":"string","description":"Batch Request Reference","key$":"reference"},"batches":{"type":"array","items":{"type":"object","properties":{"reference":{"type":"string","description":"Batch Item Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes."},"bfid":{"type":"string","description":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization."},"values":{"type":"array","items":{}}},"description":"Field Data","x-ref":"#/components/schemas/DetokenizeBatchRequestItemData"},"key$":"batches"}},"description":"Batch data to be detokenized","x-ref":"#/components/schemas/DetokenizeBatchRequest","index$":1}}},"required":true},"parameters":[]},"POST /tokenization/detokenize":{"protocol":"http","requestBody":{"description":"Data to be detokenized.","content":{"application/json":{"schema":{"required":["bfid","values"],"type":"object","properties":{"reference":{"type":"string","description":"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.","key$":"reference"},"bfid":{"type":"string","description":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.","key$":"bfid"},"values":{"type":"array","items":{"type":"object","properties":{"name":{"type":"string","description":"Field Name. This refers to the name of a field within a template."},"value":{"type":"string","description":"Field Value. This is to the encrypted value of a field. This is the data that requires detokenization."}},"description":"Field Data","x-ref":"#/components/schemas/DetokenizeRequestItemData"},"key$":"values"}},"description":"Data to be detokenized","x-ref":"#/components/schemas/DetokenizeRequest","index$":1}}},"required":true},"parameters":[]},"GET /healthcheck/detokenize":{"protocol":"http","parameters":[{"name":"bfid","in":"query","description":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.","required":true,"schema":{"type":"string"},"index$":0},{"name":"reference","in":"query","description":"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.","schema":{"type":"string"},"index$":1},{"name":"fieldNames","in":"query","description":"Field names split by |. This refers to the names of the fields within a template.","schema":{"type":"string"},"index$":2},{"name":"fieldValues","in":"query","description":"Field values split by |. This is the encrypted data that requires detokenization.","schema":{"type":"string"},"index$":3}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const detokenize_ref01_ent = client.Detokenize()
    let detokenize_ref01_data = setup.data.new.detokenize['detokenize_ref01']

    detokenize_ref01_data = (await detokenize_ref01_ent.create(detokenize_ref01_data)).data()
    assert(null != detokenize_ref01_data)


    // LIST
    const detokenize_ref01_match = {}

    const detokenize_ref01_list = (await detokenize_ref01_ent.list(detokenize_ref01_match)).map((e) => e.data())


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/detokenize/DetokenizeTestData.json')

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
    ['detokenize01','detokenize02','detokenize03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'BLUEFIN_SHIELDCONEX_TEST_DETOKENIZE_ENTID': idmap,
    'BLUEFIN_SHIELDCONEX_TEST_LIVE': 'FALSE',
    'BLUEFIN_SHIELDCONEX_TEST_EXPLAIN': 'FALSE',
    'BLUEFIN_SHIELDCONEX_APIKEY': '',
  })

  idmap = env['BLUEFIN_SHIELDCONEX_TEST_DETOKENIZE_ENTID']

  const live = 'TRUE' === env.BLUEFIN_SHIELDCONEX_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['BLUEFIN_SHIELDCONEX_TEST_DETOKENIZE_ENTID']
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
  
