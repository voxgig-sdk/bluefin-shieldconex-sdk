// tokenize_read entity test (generated from the API model).

import XCTest

@testable import BluefinShieldconexSdk

final class TokenizeReadEntityTest: XCTestCase {
  func testInstance() {
    let sdk = BluefinShieldconexSDK.testSDK(nil, nil)
    let ent = sdk.TokenizeRead()
    XCTAssertEqual(ent.getName(), "tokenize_read")
  }

  // An invalid request fails with validate's own error, before it is sent.
  func testValidate() throws {
    try XCTSkipUnless(TokenizeReadEntityTest.hasFeature("validate"), "feature not present in this SDK: validate")
    let client = BluefinShieldconexSDK.testSDK(nil, vm(("feature", .map(vm(("validate", .map(vm(("active", .bool(true))))))))))
    var err: Error? = nil
    do { _ = try client.TokenizeRead().create(vm(("bfid", .int(1))), nil) } catch { err = error }
    XCTAssertEqual((err as? BluefinShieldconexError)?.code, "validate_failed",
      "expected validate_failed, got \(String(describing: err))")
  }

  // True when this SDK was generated with the named feature.
  static func hasFeature(_ name: String) -> Bool {
    gp(SdkConfig.makeConfig(), "feature").asMap?.entries[name] != nil
  }
}
