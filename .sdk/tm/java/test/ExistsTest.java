package JAVAPACKAGE.sdktest;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import JAVAPACKAGE.core.BluefinShieldconexSDK;

public class ExistsTest {

  @Test
  public void testMode() {
    BluefinShieldconexSDK testsdk = BluefinShieldconexSDK.testSDK();
    assertNotNull(testsdk, "expected non-nil SDK");
  }
}
