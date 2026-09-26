
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { BluefinShieldconexSDK } from '..'


describe('exists', async () => {

  test('test-mode', () => {
    const testsdk = BluefinShieldconexSDK.test()
    equal(testsdk instanceof BluefinShieldconexSDK, true,
      'BluefinShieldconexSDK.test() must return a client synchronously')
  })

})
