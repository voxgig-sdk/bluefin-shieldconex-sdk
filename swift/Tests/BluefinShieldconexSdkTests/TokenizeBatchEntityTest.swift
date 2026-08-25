// tokenize_batch entity test (generated from the API model).

import XCTest

@testable import BluefinShieldconexSdk

final class TokenizeBatchEntityTest: XCTestCase {
  func testInstance() {
    let sdk = BluefinShieldconexSDK.testSDK(nil, nil)
    let ent = sdk.TokenizeBatch()
    XCTAssertEqual(ent.getName(), "tokenize_batch")
  }
}
