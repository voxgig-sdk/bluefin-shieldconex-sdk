package KOTLINPACKAGE.sdktest

import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Test

import KOTLINPACKAGE.core.BluefinShieldconexSDK

class ExistsTest {

  @Test
  fun testMode() {
    val testsdk = BluefinShieldconexSDK.testSDK()
    assertNotNull(testsdk, "expected non-nil SDK")
  }
}
