package voxgig.bluefinshieldconexsdk.sdktest

import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Test

import voxgig.bluefinshieldconexsdk.core.BluefinShieldconexSDK

class ExistsTest {

  @Test
  fun testMode() {
    val testsdk = BluefinShieldconexSDK.testSDK()
    assertNotNull(testsdk, "expected non-nil SDK")
  }
}
