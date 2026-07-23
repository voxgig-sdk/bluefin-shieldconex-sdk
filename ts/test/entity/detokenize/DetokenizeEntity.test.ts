
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'


import { BluefinShieldconexSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveDelay,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


describe('DetokenizeEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when BLUEFINSHIELDCONEX_TEST_LIVE=TRUE.
  afterEach(liveDelay('BLUEFINSHIELDCONEX_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = BluefinShieldconexSDK.test()
    const ent = testsdk.Detokenize()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.BLUEFIN_SHIELDCONEX_TEST_LIVE
    for (const op of ['create', 'list']) {
      if (maybeSkipControl(t, 'entityOp', 'detokenize.' + op, live)) return
    }

    const setup = basicSetup()
    // The basic flow consumes synthetic IDs and field values from the
    // fixture (entity TestData.json). Those don't exist on the live API.
    // Skip live runs unless the user provided a real ENTID env override.
    if (setup.syntheticOnly) {
      t.skip('live entity test uses synthetic IDs from fixture — set BLUEFIN_SHIELDCONEX_TEST_DETOKENIZE_ENTID JSON to run live')
      return
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const detokenize_ref01_ent = client.Detokenize()
    let detokenize_ref01_data = setup.data.new.detokenize['detokenize_ref01']

    detokenize_ref01_data = await detokenize_ref01_ent.create(detokenize_ref01_data)
    assert(null != detokenize_ref01_data)


    // LIST
    const detokenize_ref01_match: any = {}

    const detokenize_ref01_list = await detokenize_ref01_ent.list(detokenize_ref01_match)


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

  // Detect whether the user provided a real ENTID JSON via env var. The
  // basic flow consumes synthetic IDs from the fixture file; without an
  // override those synthetic IDs reach the live API and 4xx. Surface this
  // to the test so it can skip rather than fail.
  const idmapEnvVal = process.env['BLUEFIN_SHIELDCONEX_TEST_DETOKENIZE_ENTID']
  const idmapOverridden = null != idmapEnvVal && idmapEnvVal.trim().startsWith('{')

  const env = envOverride({
    'BLUEFIN_SHIELDCONEX_TEST_DETOKENIZE_ENTID': idmap,
    'BLUEFIN_SHIELDCONEX_TEST_LIVE': 'FALSE',
    'BLUEFIN_SHIELDCONEX_TEST_EXPLAIN': 'FALSE',
    'BLUEFIN_SHIELDCONEX_APIKEY': 'NONE',
  })

  idmap = env['BLUEFIN_SHIELDCONEX_TEST_DETOKENIZE_ENTID']

  const live = 'TRUE' === env.BLUEFIN_SHIELDCONEX_TEST_LIVE

  if (live) {
    client = new BluefinShieldconexSDK(merge([
      {
        apikey: env.BLUEFIN_SHIELDCONEX_APIKEY,
      },
      extra
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
    syntheticOnly: live && !idmapOverridden,
    now: Date.now(),
  }

  return setup
}
  
