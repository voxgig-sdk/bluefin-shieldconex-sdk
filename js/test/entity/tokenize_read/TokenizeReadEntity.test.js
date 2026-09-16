
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


describe('TokenizeReadEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when BLUEFIN_SHIELDCONEX_TEST_LIVE=TRUE.
  afterEach(liveDelay('BLUEFIN_SHIELDCONEX_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = BluefinShieldconexSDK.test()
    const ent = testsdk.TokenizeRead()
    assert(null != ent)
  })


  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"name":"bfid","op":{"create":{"req":true,"type":"`$STRING`"}},"req":false,"short":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).","type":"`$STRING`","index$":0},{"active":true,"name":"messageId","req":false,"short":"Message Id","type":"`$STRING`","index$":1},{"active":true,"name":"reference","req":false,"short":"Request Reference.","type":"`$STRING`","index$":2},{"active":true,"name":"state","req":false,"short":"Tokenized State Data (if available)","type":"`$OBJECT`","index$":3},{"active":true,"name":"values","req":false,"type":"`$ARRAY`","index$":4}],"name":"tokenize_read","op":{"create":{"input":"data","name":"create","points":[{"active":true,"args":{},"contract":{"id":"POST /tokenization/read","json":"{\"operationId\":\"tokenize-read\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"This request (TOKENIZATION/READ) is intended to be used to read data that was entered into a ShieldConex iFrame element (this cannot be used for API only transactions). The BFID that is created during a tokenization request is used to recall the data was used during a tokenize request. The response values would be tokenized. This activity can only be performed once per BFID.\",\"properties\":{\"bfid\":{\"description\":\"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.\",\"type\":\"string\"},\"reference\":{\"description\":\"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"}},\"required\":[\"bfid\"],\"type\":\"object\"}}},\"description\":\"Tokenized data query.\",\"required\":true},\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Tokenized read response\",\"properties\":{\"bfid\":{\"description\":\"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"},\"state\":{\"description\":\"Tokenized State Data (if available)\",\"properties\":{\"threeDs\":{\"description\":\"3DS State Data\",\"properties\":{\"acsTransId\":{\"description\":\"ACS Transaction\",\"type\":\"string\"},\"authenticationType\":{\"description\":\"Authentication Type\",\"type\":\"string\"},\"authenticationValue\":{\"description\":\"Authentication Value\",\"type\":\"string\"},\"dsTransId\":{\"description\":\"DS Transaction\",\"type\":\"string\"},\"eci\":{\"description\":\"ECI\",\"type\":\"string\"},\"protocolVersion\":{\"description\":\"Protocol Version\",\"type\":\"string\"},\"scaIndicator\":{\"description\":\"DS Transaction\",\"type\":\"string\"},\"status\":{\"description\":\"3DS status\",\"type\":\"string\"}},\"type\":\"object\"}},\"type\":\"object\"},\"values\":{\"items\":{\"description\":\"Tokenized Data\",\"properties\":{\"name\":{\"description\":\"Field Name. This refers to the name of a field within a template.\",\"type\":\"string\"},\"value\":{\"description\":\"Field Value. This is to the encrypted value of a field. This is the data that requires detokenization.\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"}}},\"description\":\"Tokenize response\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request\"},\"401\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Unauthorized\"},\"403\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Forbidden\"},\"409\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Invalid data\"},\"500\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Internal server error\"}},\"security\":[{\"basic\":[]}],\"securitySchemes\":{\"basic\":{\"scheme\":\"basic\",\"type\":\"http\"}},\"securitySource\":\"definition\"}","source":"openapi3","version":1},"kind":"http","method":"POST","orig":"/tokenization/read","segments":[{"lit":"tokenization"},{"lit":"read"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"}},"relations":{"ancestors":[]},"key$":"tokenize_read","name__orig":"tokenize_read","Name":"TokenizeRead","name_":"tokenize_read","name-":"tokenize-read","NAME":"TOKENIZE_READ","index$":3}, {"active":true,"entity":"tokenize_read","key$":"BasicTokenizeReadFlow","kind":"basic","name":"BasicTokenizeReadFlow","param":{},"step":[{"active":true,"data":{},"input":{"ref":"tokenize_read_ref01"},"match":{},"op":"create","spec":[],"valid":[],"index$":0}]}, 'TokenizeRead')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const tokenize_read_ref01_ent = client.TokenizeRead()
    let tokenize_read_ref01_data = setup.data.new.tokenize_read['tokenize_read_ref01']

    tokenize_read_ref01_data = (await tokenize_read_ref01_ent.create(tokenize_read_ref01_data)).data()
    assert(null != tokenize_read_ref01_data)


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/tokenize_read/TokenizeReadTestData.json')

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
    ['tokenize_read01','tokenize_read02','tokenize_read03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_READ_ENTID': idmap,
    'BLUEFIN_SHIELDCONEX_TEST_LIVE': 'FALSE',
    'BLUEFIN_SHIELDCONEX_TEST_EXPLAIN': 'FALSE',
    'BLUEFIN_SHIELDCONEX_APIKEY': '',
  })

  idmap = env['BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_READ_ENTID']

  const live = 'TRUE' === env.BLUEFIN_SHIELDCONEX_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_READ_ENTID']
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
  
