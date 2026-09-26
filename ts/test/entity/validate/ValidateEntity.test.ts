

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


describe('ValidateEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when BLUEFIN_SHIELDCONEX_TEST_LIVE=TRUE.
  afterEach(liveDelay('BLUEFIN_SHIELDCONEX_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = BluefinShieldconexSDK.test()
    const ent = testsdk.Validate()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.BLUEFIN_SHIELDCONEX_TEST_LIVE
    for (const op of ['create']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'validate.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"messageId":{"a":true,"h":"Message Id","n":"messageId","r":false,"sh":"Message Id","t":"`$STRING`","key$":"messageId","index$":0},"reference":{"a":true,"h":"Reference","n":"reference","r":false,"sh":"Request Reference.","t":"`$STRING`","key$":"reference","index$":1},"templateRef":{"a":true,"h":"Template Ref","n":"templateRef","r":true,"sh":"Template Reference.","t":"`$STRING`","key$":"templateRef","index$":2}},"name":"validate","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /partner/validate","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/partner/validate","q":{},"r":{},"s":[{"lit":"partner"},{"lit":"validate"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"POST /template/validate","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/template/validate","q":{},"r":{},"s":[{"lit":"template"},{"lit":"validate"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1}],"key$":"create"}},"relations":{"ancestors":[]},"key$":"validate","name__orig":"validate","Name":"Validate","name_":"validate","name-":"validate","NAME":"VALIDATE","index$":4}, {"active":true,"entity":"validate","key$":"BasicValidateFlow","kind":"basic","name":"BasicValidateFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"validate_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0}]}, 'Validate', {"POST /partner/validate":{"protocol":"http","requestBody":{"description":"Partner to be validated.","content":{"application/json":{"schema":{"type":"object","properties":{"reference":{"type":"string","description":"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.","key$":"reference"}},"description":"Partner to be validated","x-ref":"#/components/schemas/PartnerValidateRequest","index$":1}}},"required":true},"parameters":[]},"POST /template/validate":{"protocol":"http","requestBody":{"description":"Template to be validated.","content":{"application/json":{"schema":{"required":["templateRef"],"type":"object","properties":{"reference":{"type":"string","description":"Request Reference. This is a reference value that Developers can use to track API requests and responses. It is solely for tracking purposes.","key$":"reference"},"templateRef":{"type":"string","description":"Template Reference. This is the unique alphanumeric string that is used to identify a template. The templateRef is created within ShieldConex Manager and can be found within the template details page of any template within ShieldConex Manager.","key$":"templateRef"}},"description":"Template to be validated","x-ref":"#/components/schemas/TemplateValidateRequest","index$":1}}},"required":true},"parameters":[]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const validate_ref01_ent = client.Validate()
    let validate_ref01_data = setup.data.new.validate['validate_ref01']

    validate_ref01_data = (await validate_ref01_ent.create(validate_ref01_data)).data()
    assert(null != validate_ref01_data)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/validate/ValidateTestData.json')

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
    ['validate01','validate02','validate03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID': idmap,
    'BLUEFIN_SHIELDCONEX_TEST_LIVE': 'FALSE',
    'BLUEFIN_SHIELDCONEX_TEST_EXPLAIN': 'FALSE',
    'BLUEFIN_SHIELDCONEX_APIKEY': '',
    'BLUEFIN_SHIELDCONEX_SECRET': '',
  })

  idmap = env['BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID']

  const live = 'TRUE' === env.BLUEFIN_SHIELDCONEX_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['BLUEFIN_SHIELDCONEX_TEST_VALIDATE_ENTID']
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
  
