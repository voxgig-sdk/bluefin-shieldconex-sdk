// tokenize_batch entity test (generated from the API model).

import XCTest

@testable import BluefinShieldconexSdk

final class TokenizeBatchEntityTest: XCTestCase {
  func testInstance() {
    let sdk = BluefinShieldconexSDK.testSDK(nil, nil)
    let ent = sdk.TokenizeBatch()
    XCTAssertEqual(ent.getName(), "tokenize_batch")
  }

  // An invalid request fails with validate's own error, before it is sent.
  func testValidate() throws {
    try XCTSkipUnless(TokenizeBatchEntityTest.hasFeature("validate"), "feature not present in this SDK: validate")
    let client = BluefinShieldconexSDK.testSDK(nil, vm(("feature", .map(vm(("validate", .map(vm(("active", .bool(true))))))))))
    var err: Error? = nil
    do { _ = try client.TokenizeBatch().create(vm(("messageId", .int(1))), nil) } catch { err = error }
    XCTAssertEqual((err as? BluefinShieldconexError)?.code, "validate_failed",
      "expected validate_failed, got \(String(describing: err))")
  }

  // True when this SDK was generated with the named feature.
  static func hasFeature(_ name: String) -> Bool {
    gp(SdkConfig.makeConfig(), "feature").asMap?.entries[name] != nil
  }
}
