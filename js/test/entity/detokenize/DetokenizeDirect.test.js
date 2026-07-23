
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

const { test, describe } = require('node:test')
const assert = require('node:assert')


const { BluefinShieldconexSDK } = require('../../..')

const {
  envOverride,
} = require('../../utility')


describe('DetokenizeDirect', async () => {

  test('direct-exists', async () => {
    const sdk = new BluefinShieldconexSDK({
      system: { fetch: async () => ({}) }
    })
    assert('function' === typeof sdk.direct)
    assert('function' === typeof sdk.prepare)
  })


  test('direct-list-detokenize', async () => {
    const setup = directSetup([{ id: 'direct01' }, { id: 'direct02' }])
    const { client, calls } = setup

    const params = {}

    const result = await client.direct({
      path: 'healthcheck/detokenize',
      method: 'GET',
      params,
    })

    assert(result.ok === true)
    assert(result.status === 200)
    assert(Array.isArray(result.data))

    if (!setup.live) {
      assert(result.data.length === 2)
      assert(calls.length === 1)
      assert(calls[0].init.method === 'GET')
    }
  })

})



function directSetup(mockres) {
  const calls = []

  const env = envOverride({
    'BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID': {},
    'BLUEFINSHIELDCONEX_TEST_LIVE': 'FALSE',
    'BLUEFINSHIELDCONEX_APIKEY': 'NONE',
  })

  const live = 'TRUE' === env.BLUEFINSHIELDCONEX_TEST_LIVE

  if (live) {
    const client = new BluefinShieldconexSDK({
      apikey: env.BLUEFINSHIELDCONEX_APIKEY,
    })

    let idmap = env['BLUEFINSHIELDCONEX_TEST_DETOKENIZE_ENTID']
    if ('string' === typeof idmap && idmap.startsWith('{')) {
      idmap = JSON.parse(idmap)
    }

    return { client, calls, live, idmap }
  }

  const mockFetch = async (url, init) => {
    calls.push({ url, init })
    return {
      status: 200,
      statusText: 'OK',
      headers: {},
      json: async () => (null != mockres ? mockres : { id: 'direct01' }),
    }
  }

  const client = new BluefinShieldconexSDK({
    base: 'http://localhost:8080',
    system: { fetch: mockFetch },
  })

  return { client, calls, live, idmap: {} }
}
  
