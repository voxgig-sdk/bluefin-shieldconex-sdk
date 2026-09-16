

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


describe('TokenizeBatchEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when BLUEFIN_SHIELDCONEX_TEST_LIVE=TRUE.
  afterEach(liveDelay('BLUEFIN_SHIELDCONEX_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = BluefinShieldconexSDK.test()
    const ent = testsdk.TokenizeBatch()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.BLUEFIN_SHIELDCONEX_TEST_LIVE
    for (const op of ['create']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'tokenize_batch.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"name":"batches","op":{"create":{"req":true,"type":"`$ARRAY`"}},"req":false,"type":"`$ARRAY`","index$":0},{"active":true,"name":"messageId","req":false,"short":"Message Id","type":"`$STRING`","index$":1},{"active":true,"name":"reference","req":false,"short":"Request Reference.","type":"`$STRING`","index$":2}],"name":"tokenize_batch","op":{"create":{"input":"data","name":"create","points":[{"active":true,"args":{},"contract":{"id":"POST /tokenization/batch/delete","json":"{\"operationId\":\"tokenize-delete-batch\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Read and delete tokenized data query\",\"properties\":{\"batches\":{\"items\":{\"description\":\"Data to be read and deleted\",\"properties\":{\"bfid\":{\"description\":\"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.\",\"type\":\"string\"},\"reference\":{\"description\":\"Batch Item Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"}},\"required\":[\"bfid\"],\"type\":\"object\"},\"type\":\"array\"},\"reference\":{\"description\":\"Batch Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"}},\"required\":[\"batches\"],\"type\":\"object\"}}},\"description\":\"Tokenized delete batch data query.\",\"required\":true},\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Tokenized batch response\",\"properties\":{\"batches\":{\"items\":{\"description\":\"Tokenized data\",\"properties\":{\"bfid\":{\"description\":\"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.\",\"type\":\"string\"},\"reference\":{\"description\":\"Batch Item Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"},\"values\":{\"items\":{\"description\":\"Tokenized Data\",\"properties\":{\"name\":{\"description\":\"Field Name. This refers to the name of a field within a template.\",\"type\":\"string\"},\"value\":{\"description\":\"Field Value. This is to the encrypted value of a field. This is the data that requires detokenization.\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"},\"type\":\"array\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"},\"reference\":{\"description\":\"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Tokenize batch response\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request\"},\"401\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Unauthorized\"},\"403\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Forbidden\"},\"409\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Invalid data\"},\"500\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Internal server error\"}},\"security\":[{\"basic\":[]}],\"securitySchemes\":{\"basic\":{\"scheme\":\"basic\",\"type\":\"http\"}},\"securitySource\":\"definition\"}","source":"openapi3","version":1},"kind":"http","method":"POST","orig":"/tokenization/batch/delete","segments":[{"lit":"tokenization"},{"lit":"batch"},{"lit":"delete"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0},{"active":true,"args":{},"contract":{"id":"POST /tokenization/batch/read","json":"{\"operationId\":\"tokenize-read-batch\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Read tokenized batch data query\",\"properties\":{\"batches\":{\"items\":{\"description\":\"Data to be read\",\"properties\":{\"bfid\":{\"description\":\"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.\",\"type\":\"string\"},\"reference\":{\"description\":\"Batch Item Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"}},\"required\":[\"bfid\"],\"type\":\"object\"},\"type\":\"array\"},\"reference\":{\"description\":\"Batch Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"}},\"required\":[\"batches\"],\"type\":\"object\"}}},\"description\":\"Tokenized read batch data query.\",\"required\":true},\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Tokenized batch response\",\"properties\":{\"batches\":{\"items\":{\"description\":\"Tokenized data\",\"properties\":{\"bfid\":{\"description\":\"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.\",\"type\":\"string\"},\"reference\":{\"description\":\"Batch Item Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"},\"values\":{\"items\":{\"description\":\"Tokenized Data\",\"properties\":{\"name\":{\"description\":\"Field Name. This refers to the name of a field within a template.\",\"type\":\"string\"},\"value\":{\"description\":\"Field Value. This is to the encrypted value of a field. This is the data that requires detokenization.\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"},\"type\":\"array\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"},\"reference\":{\"description\":\"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Tokenize batch response\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request\"},\"401\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Unauthorized\"},\"403\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Forbidden\"},\"409\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Invalid data\"},\"500\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"\",\"properties\":{\"errCode\":{\"description\":\"Error code\",\"type\":\"number\"},\"errMessage\":{\"description\":\"Error message\",\"type\":\"string\"},\"itemIndex\":{\"description\":\"Batch Item Index (optional)\",\"type\":\"number\"},\"itemReference\":{\"description\":\"Batch Item Reference (optional)\",\"type\":\"string\"},\"messageId\":{\"description\":\"Message Id\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Internal server error\"}},\"security\":[{\"basic\":[]}],\"securitySchemes\":{\"basic\":{\"scheme\":\"basic\",\"type\":\"http\"}},\"securitySource\":\"definition\"}","source":"openapi3","version":1},"kind":"http","method":"POST","orig":"/tokenization/batch/read","segments":[{"lit":"tokenization"},{"lit":"batch"},{"lit":"read"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":1}],"key$":"create"}},"relations":{"ancestors":[]},"key$":"tokenize_batch","name__orig":"tokenize_batch","Name":"TokenizeBatch","name_":"tokenize_batch","name-":"tokenize-batch","NAME":"TOKENIZE_BATCH","index$":2}, {"active":true,"entity":"tokenize_batch","key$":"BasicTokenizeBatchFlow","kind":"basic","name":"BasicTokenizeBatchFlow","param":{},"step":[{"active":true,"data":{},"input":{"ref":"tokenize_batch_ref01"},"match":{},"op":"create","spec":[],"valid":[],"index$":0}]}, 'TokenizeBatch')
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



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

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
    'BLUEFIN_SHIELDCONEX_SECRET': '',
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
  
