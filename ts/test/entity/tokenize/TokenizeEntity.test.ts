

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


loadEnvLocal(__dirname + '/../../../.env.local')


describe('TokenizeEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when BLUEFIN_SHIELDCONEX_TEST_LIVE=TRUE.
  afterEach(liveDelay('BLUEFIN_SHIELDCONEX_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = BluefinShieldconexSDK.test()
    const ent = testsdk.Tokenize()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.BLUEFIN_SHIELDCONEX_TEST_LIVE
    for (const op of ['create', 'list']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'tokenize.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"batches":{"a":true,"h":"Batches","n":"batches","op":{"create":{"req":true,"type":"`$ARRAY`"}},"r":false,"t":"`$ARRAY`","key$":"batches","index$":0},"bfid":{"a":true,"h":"Bfid","n":"bfid","op":{"create":{"req":true,"type":"`$STRING`"}},"r":false,"sh":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).","t":"`$STRING`","key$":"bfid","index$":1},"messageId":{"a":true,"h":"Message Id","n":"messageId","r":false,"sh":"Message Id","t":"`$STRING`","key$":"messageId","index$":2},"name":{"a":true,"h":"Name","n":"name","r":false,"sh":"Field Name.","t":"`$STRING`","key$":"name","index$":3},"reference":{"a":true,"h":"Reference","n":"reference","r":false,"sh":"Request Reference.","t":"`$STRING`","key$":"reference","index$":4},"templateRef":{"a":true,"h":"Template Ref","n":"templateRef","r":true,"sh":"Template Reference","t":"`$STRING`","key$":"templateRef","index$":5},"value":{"a":true,"h":"Value","n":"value","r":false,"sh":"Field Value.","t":"`$STRING`","key$":"value","index$":6},"values":{"a":true,"h":"Values","n":"values","op":{"create":{"req":true,"type":"`$ARRAY`"}},"r":false,"t":"`$ARRAY`","key$":"values","index$":7}},"name":"tokenize","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /tokenization/batch/tokenize","source":"openapi3","version":2},"g":{"query":[{"a":true,"k":"query","n":"omit","or":"omit","r":false,"t":"`$NUMBER`","index$":0}]},"k":"http","m":"POST","o":"/tokenization/batch/tokenize","q":{"exist":["omit"]},"r":{},"s":[{"lit":"tokenization"},{"lit":"batch"},{"lit":"tokenize"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"POST /tokenization/tokenize","source":"openapi3","version":2},"g":{"query":[{"a":true,"k":"query","n":"omit","or":"omit","r":false,"t":"`$NUMBER`","index$":0}]},"k":"http","m":"POST","o":"/tokenization/tokenize","q":{"exist":["omit"]},"r":{},"s":[{"lit":"tokenization"},{"lit":"tokenize"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"POST /tokenization/delete","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/tokenization/delete","q":{},"r":{},"s":[{"lit":"tokenization"},{"lit":"delete"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":2}],"key$":"create"},"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /healthcheck/tokenize","source":"openapi3","version":2},"g":{"query":[{"a":true,"k":"query","n":"field_name","or":"field_name","r":false,"t":"`$STRING`","index$":0},{"a":true,"k":"query","n":"field_value","or":"field_value","r":false,"t":"`$STRING`","index$":1},{"a":true,"k":"query","n":"reference","or":"reference","r":false,"t":"`$STRING`","index$":2},{"a":true,"k":"query","n":"template_ref","or":"template_ref","r":true,"t":"`$STRING`","index$":3}]},"k":"http","m":"GET","o":"/healthcheck/tokenize","q":{"exist":["field_name","field_value","reference","template_ref"]},"r":{},"s":[{"lit":"healthcheck"},{"lit":"tokenize"}],"t":{"req":"`reqdata`","res":"`body.values`"},"index$":0}],"key$":"list"}},"relations":{"ancestors":[]},"key$":"tokenize","name__orig":"tokenize","Name":"Tokenize","name_":"tokenize","name-":"tokenize","NAME":"TOKENIZE","index$":1}, {"active":true,"entity":"tokenize","key$":"BasicTokenizeFlow","kind":"basic","name":"BasicTokenizeFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"tokenize_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"tokenize_ref01"}}],"index$":1}]}, 'Tokenize', {"POST /tokenization/batch/tokenize":{"protocol":"http","requestBody":{"description":"Data to be tokenized.","content":{"application/json":{"schema":{"required":["batches","templateRef"],"type":"object","properties":{"reference":{"type":"string","description":"Batch Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.","key$":"reference"},"templateRef":{"type":"string","description":"Template Reference","key$":"templateRef"},"batches":{"type":"array","items":{"required":["values"],"type":"object","properties":{"reference":{"type":"string","description":"Batch Item Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes."},"values":{"type":"array","items":{}}},"description":"Batch item data to be tokenized","x-ref":"#/components/schemas/TokenizeBatchRequestItemData"},"key$":"batches"}},"description":"Batch data to be tokenized","x-ref":"#/components/schemas/TokenizeBatchRequest","index$":1}}},"required":true},"parameters":[{"name":"omit","in":"query","description":"Set this parameter to 1 if data shouldn't be present in response but can be received by separate 'read' request","schema":{"type":"number"},"index$":0}]},"POST /tokenization/tokenize":{"protocol":"http","requestBody":{"description":"Data to be tokenized.","content":{"application/json":{"schema":{"required":["templateRef","values"],"type":"object","properties":{"reference":{"type":"string","description":"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.","key$":"reference"},"templateRef":{"type":"string","description":"Template Reference. This is the unique alphanumeric string that is used to identify a template. The templateRef is created within ShieldConex Manager and can be found within the template details page of any template within ShieldConex Manager.","key$":"templateRef"},"values":{"type":"array","items":{"type":"object","properties":{"name":{"type":"string","description":"Field Name. This refers to the name of a field within a template."},"value":{"type":"string","description":"Field Value. This is to the cleartext value that is entered into a field. This is the data that requires tokenization."}},"description":"JSON array containing the field names (and desired values) matching the fields configured inside of the template being referenced with templateRef.","x-ref":"#/components/schemas/TokenizeRequestItemData"},"key$":"values"}},"description":"Data to be tokenized","x-ref":"#/components/schemas/TokenizeRequest","index$":1}}},"required":true},"parameters":[{"name":"omit","in":"query","description":"Set this parameter to 1 if data shouldn't be present in response but can be received by separate 'read' request. Set this parameter to 2 if data still should be present in response but also can be received by separate 'read' request. ","schema":{"type":"number"},"index$":0}]},"POST /tokenization/delete":{"protocol":"http","requestBody":{"description":"Tokenized data query.","content":{"application/json":{"schema":{"required":["bfid"],"type":"object","properties":{"reference":{"type":"string","description":"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.","key$":"reference"},"bfid":{"type":"string","description":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).  The BFID refers to that specific tokenization request and is necessary for tokenization and detokenization.","key$":"bfid"}},"description":"Tokenized and detele data query","x-ref":"#/components/schemas/TokenizeDeleteRequest","index$":1}}},"required":true},"parameters":[]},"GET /healthcheck/tokenize":{"protocol":"http","parameters":[{"name":"templateRef","in":"query","description":"Template Reference. This is the unique alphanumeric string that is used to identify a template. The templateRef is created within ShieldConex Manager and can be found within the template details page of any template within ShieldConex Manager.","required":true,"schema":{"type":"string"},"index$":0},{"name":"reference","in":"query","description":"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.","schema":{"type":"string"},"index$":1},{"name":"fieldNames","in":"query","description":"Field names split by |. This refers to the names of the fields within a template.","schema":{"type":"string"},"index$":2},{"name":"fieldValues","in":"query","description":"Field values split by |. This is the data that requires tokenization.","schema":{"type":"string"},"index$":3}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const tokenize_ref01_ent = client.Tokenize()
    let tokenize_ref01_data = setup.data.new.tokenize['tokenize_ref01']

    tokenize_ref01_data = (await tokenize_ref01_ent.create(tokenize_ref01_data)).data()
    assert(null != tokenize_ref01_data)


    // LIST
    const tokenize_ref01_match: any = {}

    const tokenize_ref01_list = (await tokenize_ref01_ent.list(tokenize_ref01_match)).map((e: any) => e.data())


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/tokenize/TokenizeTestData.json')

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
    ['tokenize01','tokenize02','tokenize03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_ENTID': idmap,
    'BLUEFIN_SHIELDCONEX_TEST_LIVE': 'FALSE',
    'BLUEFIN_SHIELDCONEX_TEST_EXPLAIN': 'FALSE',
    'BLUEFIN_SHIELDCONEX_APIKEY': '',
    'BLUEFIN_SHIELDCONEX_SECRET': '',
  })

  idmap = env['BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_ENTID']

  const live = 'TRUE' === env.BLUEFIN_SHIELDCONEX_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_ENTID']
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
  
