
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

const Path = require('node:path')
const Fs = require('node:fs')

const { test, describe } = require('node:test')
const assert = require('node:assert')


const { BluefinShieldconexSDK, BaseFeature, stdutil, config } = require('../../..')

const {
  envOverride,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
} = require('../../utility')


describe('TokenizeEntity', async () => {

  test('instance', async () => {
    const testsdk = BluefinShieldconexSDK.test()
    const ent = testsdk.Tokenize()
    assert(null != ent)
  })


  test('basic', async () => {

    const setup = basicSetup()
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
    const tokenize_ref01_match = {}

    const tokenize_ref01_list = (await tokenize_ref01_ent.list(tokenize_ref01_match)).map((e) => e.data())


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

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
    'BLUEFIN_SHIELDCONEX_APIKEY': 'NONE',
  })

  idmap = env['BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_ENTID']

  if ('TRUE' === env.BLUEFIN_SHIELDCONEX_TEST_LIVE) {
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
    now: Date.now(),
  }

  return setup
}
  
