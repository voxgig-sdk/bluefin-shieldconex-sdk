package voxgig.bluefinshieldconexsdk.core

import java.util.{Map => JMap}

// BluefinShieldconex SDK client. All transport and pipeline behaviour lives in the
// SdkClient base (core/SdkClient.scala); this class binds the API-specific
// entity accessors and the test-mode constructor.
class BluefinShieldconexSDK(options: JMap[String, Object]) extends SdkClient(options) {

  def this() = this(null)


  /**
   * Returns a detokenize entity bound to this client.
   * Idiomatic usage: client.detokenize(null).list(null, null) or
   * client.detokenize(null).load(java.util.Map.of("id", ...), null).
   */
  def detokenize(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.bluefinshieldconexsdk.entity.DetokenizeEntity(this, entopts)

  /**
   * Returns a tokenize entity bound to this client.
   * Idiomatic usage: client.tokenize(null).list(null, null) or
   * client.tokenize(null).load(java.util.Map.of("id", ...), null).
   */
  def tokenize(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.bluefinshieldconexsdk.entity.TokenizeEntity(this, entopts)

  /**
   * Returns a tokenize_batch entity bound to this client.
   * Idiomatic usage: client.tokenizeBatch(null).list(null, null) or
   * client.tokenizeBatch(null).load(java.util.Map.of("id", ...), null).
   */
  def tokenizeBatch(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.bluefinshieldconexsdk.entity.TokenizeBatchEntity(this, entopts)

  /**
   * Returns a tokenize_read entity bound to this client.
   * Idiomatic usage: client.tokenizeRead(null).list(null, null) or
   * client.tokenizeRead(null).load(java.util.Map.of("id", ...), null).
   */
  def tokenizeRead(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.bluefinshieldconexsdk.entity.TokenizeReadEntity(this, entopts)

  /**
   * Returns a validate entity bound to this client.
   * Idiomatic usage: client.validate(null).list(null, null) or
   * client.validate(null).load(java.util.Map.of("id", ...), null).
   */
  def validate(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.bluefinshieldconexsdk.entity.ValidateEntity(this, entopts)


}

object BluefinShieldconexSDK {

  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  def testSDK(): BluefinShieldconexSDK = testSDK(null, null)

  def testSDK(testopts: JMap[String, Object], sdkopts: JMap[String, Object]): BluefinShieldconexSDK = {
    val sdk = new BluefinShieldconexSDK(SdkClient.testOptions(testopts, sdkopts))
    sdk.mode = "test"
    sdk
  }
}
