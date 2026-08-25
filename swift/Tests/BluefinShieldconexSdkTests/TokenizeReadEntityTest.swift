// tokenize_read entity test (generated from the API model).

import XCTest

@testable import BluefinShieldconexSdk

final class TokenizeReadEntityTest: XCTestCase {
  func testInstance() {
    let sdk = BluefinShieldconexSDK.testSDK(nil, nil)
    let ent = sdk.TokenizeRead()
    XCTAssertEqual(ent.getName(), "tokenize_read")
  }
}
