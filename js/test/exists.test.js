
const { test, describe } = require('node:test')
const { equal } = require('node:assert')


const { BluefinShieldconexSDK } = require('..')


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await BluefinShieldconexSDK.test()
    equal(null !== testsdk, true)
  })

})
