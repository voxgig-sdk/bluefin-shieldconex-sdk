
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { BluefinShieldconexSDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await BluefinShieldconexSDK.test()
    equal(null !== testsdk, true)
  })

})
