// validate entity test (generated from the API model).

import XCTest

@testable import BluefinShieldconexSdk

final class ValidateEntityTest: XCTestCase {
  func testInstance() {
    let sdk = BluefinShieldconexSDK.testSDK(nil, nil)
    let ent = sdk.Validate()
    XCTAssertEqual(ent.getName(), "validate")
  }
}
