// BluefinShieldconex SDK exists test.

import XCTest

@testable import BluefinShieldconexSdk

final class ExistsTest: XCTestCase {
  func testMode() {
    let testsdk = BluefinShieldconexSDK.testSDK(nil, nil)
    XCTAssertEqual(testsdk.mode, "test")
  }
}
