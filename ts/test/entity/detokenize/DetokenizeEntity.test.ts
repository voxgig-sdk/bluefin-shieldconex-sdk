

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { BluefinShieldconexSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
loadEnvLocal(__dirname + '/../../../.env.local')


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

    const live = 'TRUE' === process.env.BLUEFIN_SHIELDCONEX_TEST_LIVE
    for (const op of ['create', 'list']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'detokenize.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"name":"batches","op":{"create":{"req":true,"type":"`$ARRAY`"}},"req":false,"type":"`$ARRAY`","index$":0},{"active":true,"name":"bfid","op":{"create":{"req":true,"type":"`$STRING`"}},"req":false,"short":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).","type":"`$STRING`","index$":1},{"active":true,"name":"messageId","req":false,"short":"Message Id","type":"`$STRING`","index$":2},{"active":true,"name":"name","req":false,"short":"Field Name.","type":"`$STRING`","index$":3},{"active":true,"name":"reference","req":false,"short":"Request Reference.","type":"`$STRING`","index$":4},{"active":true,"name":"value","req":false,"short":"Field Value.","type":"`$STRING`","index$":5},{"active":true,"name":"values","op":{"create":{"req":true,"type":"`$ARRAY`"}},"req":false,"type":"`$ARRAY`","index$":6}],"name":"detokenize","op":{"create":{"input":"data","name":"create","points":[{"active":true,"args":{},"contract":{"id":"POST /tokenization/batch/detokenize","json":"{\"operationId\":\"detokenize-batch\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Batch data to be detokenized\",\"properties\":{\"batches\":{\"items\":{\"description\":\"Field Data\",\"properties\":{\"bfid\":{\"description\":\"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.\",\"type\":\"string\"},\"reference\":{\"description\":\"Batch Item Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"},\"values\":{\"items\":{\"description\":\"Field Data\",\"properties\":{\"name\":{\"description\":\"Field Name. This refers to the name of a field within a template.\",\"type\":\"string\"},\"value\":{\"description\":\"Field Value. This is to the encrypted value of a field. This is the data that requires detokenization.\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"},\"type\":\"array\"},\"reference\":{\"description\":\"Batch Request Reference\",\"type\":\"string\"}},\"required\":[\"batches\"],\"type\":\"object\"}}},\"description\":\"Batch data to be detokenized.\",\"required\":true},\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Detokenize batch response\",\"properties\":{\"batches\":{\"items\":{\"description\":\"Detokenize batch response item\",\"properties\":{\"reference\":{\"description\":\"Batch Item Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"},\"values\":{\"items\":{\"description\":\"Detokenize Data\",\"properties\":{\"name\":{\"description\":\"Field Name. This refers to the name of a field within a template.\",\"type\":\"string\"},\"value\":{\"description\":\"Field Value. This is to the encrypted value of a field. This is the data that requires detokenization.\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"},\"type\":\"array\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"},\"reference\":{\"description\":\"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Detokenize data response\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request\"},\"401\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Unauthorized\"},\"403\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Forbidden\"},\"409\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Invalid data\"},\"500\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Internal server error\"}},\"security\":[{\"basic\":[]}],\"securitySchemes\":{\"basic\":{\"scheme\":\"basic\",\"type\":\"http\"}},\"securitySource\":\"definition\"}","source":"openapi3","version":1},"kind":"http","method":"POST","orig":"/tokenization/batch/detokenize","segments":[{"lit":"tokenization"},{"lit":"batch"},{"lit":"detokenize"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0},{"active":true,"args":{},"contract":{"id":"POST /tokenization/detokenize","json":"{\"operationId\":\"detokenize\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Data to be detokenized\",\"properties\":{\"bfid\":{\"description\":\"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.\",\"type\":\"string\"},\"reference\":{\"description\":\"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"},\"values\":{\"items\":{\"description\":\"Field Data\",\"properties\":{\"name\":{\"description\":\"Field Name. This refers to the name of a field within a template.\",\"type\":\"string\"},\"value\":{\"description\":\"Field Value. This is to the encrypted value of a field. This is the data that requires detokenization.\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"required\":[\"bfid\",\"values\"],\"type\":\"object\"}}},\"description\":\"Data to be detokenized.\",\"required\":true},\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Detokenize response\",\"properties\":{\"bfid\":{\"description\":\"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"},\"values\":{\"items\":{\"description\":\"Detokenize Data\",\"properties\":{\"name\":{\"description\":\"Field Name. This refers to the name of a field within a template.\",\"type\":\"string\"},\"value\":{\"description\":\"Field Value. This is to the encrypted value of a field. This is the data that requires detokenization.\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"}}},\"description\":\"Detokenize response\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request\"},\"401\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Unauthorized\"},\"403\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Forbidden\"},\"409\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Invalid data\"},\"500\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Internal server error\"}},\"security\":[{\"basic\":[]}],\"securitySchemes\":{\"basic\":{\"scheme\":\"basic\",\"type\":\"http\"}},\"securitySource\":\"definition\"}","source":"openapi3","version":1},"kind":"http","method":"POST","orig":"/tokenization/detokenize","segments":[{"lit":"tokenization"},{"lit":"detokenize"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"list":{"input":"data","name":"list","points":[{"active":true,"args":{"query":[{"active":true,"kind":"query","name":"bfid","orig":"bfid","reqd":true,"type":"`$STRING`","index$":0},{"active":true,"kind":"query","name":"field_name","orig":"field_name","reqd":false,"type":"`$STRING`","index$":1},{"active":true,"kind":"query","name":"field_value","orig":"field_value","reqd":false,"type":"`$STRING`","index$":2},{"active":true,"kind":"query","name":"reference","orig":"reference","reqd":false,"type":"`$STRING`","index$":3}]},"contract":{"id":"GET /healthcheck/detokenize","json":"{\"operationId\":\"healthcheck-detokenize\",\"parameters\":[{\"description\":\"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.\",\"in\":\"query\",\"name\":\"bfid\",\"required\":true,\"schema\":{\"type\":\"string\"}},{\"description\":\"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"in\":\"query\",\"name\":\"reference\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Field names split by |. This refers to the names of the fields within a template.\",\"in\":\"query\",\"name\":\"fieldNames\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Field values split by |. This is the encrypted data that requires detokenization.\",\"in\":\"query\",\"name\":\"fieldValues\",\"schema\":{\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Detokenize response\",\"properties\":{\"bfid\":{\"description\":\"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"},\"values\":{\"items\":{\"description\":\"Detokenize Data\",\"properties\":{\"name\":{\"description\":\"Field Name. This refers to the name of a field within a template.\",\"type\":\"string\"},\"value\":{\"description\":\"Field Value. This is to the encrypted value of a field. This is the data that requires detokenization.\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"}}},\"description\":\"Detokeniz response\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request\"},\"401\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Unauthorized\"},\"403\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Forbidden\"},\"409\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Invalid data\"},\"500\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Internal server error\"}},\"security\":[{\"basic\":[]}],\"securitySchemes\":{\"basic\":{\"scheme\":\"basic\",\"type\":\"http\"}},\"securitySource\":\"definition\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/healthcheck/detokenize","segments":[{"lit":"healthcheck"},{"lit":"detokenize"}],"select":{"exist":["bfid","field_name","field_value","reference"]},"transform":{"req":"`reqdata`","res":"`body.values`"},"index$":0}],"key$":"list"}},"relations":{"ancestors":[]},"key$":"detokenize","name__orig":"detokenize","Name":"Detokenize","name_":"detokenize","name-":"detokenize","NAME":"DETOKENIZE","index$":0}, {"active":true,"entity":"detokenize","key$":"BasicDetokenizeFlow","kind":"basic","name":"BasicDetokenizeFlow","param":{},"step":[{"active":true,"data":{},"input":{"ref":"detokenize_ref01"},"match":{},"op":"create","spec":[],"valid":[],"index$":0},{"active":true,"data":{},"input":{},"match":{},"op":"list","spec":[],"valid":[{"apply":"ItemExists","def":{"ref":"detokenize_ref01"}}],"index$":1}]}, 'Detokenize')
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
    const detokenize_ref01_match: any = {}

    const detokenize_ref01_list = (await detokenize_ref01_ent.list(detokenize_ref01_match)).map((e: any) => e.data())


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

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
    'BLUEFIN_SHIELDCONEX_SECRET': '',
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
        secret: env.BLUEFIN_SHIELDCONEX_SECRET,
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
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
  
