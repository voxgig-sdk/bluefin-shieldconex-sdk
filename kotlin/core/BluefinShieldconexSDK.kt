package voxgig.bluefinshieldconexsdk.core

/**
 * BluefinShieldconex SDK client. All transport and pipeline behaviour lives in the
 * SdkClient base (core/SdkClient.kt); this class binds the API-specific
 * entity accessors and the test-mode constructor.
 */
class BluefinShieldconexSDK(options: MutableMap<String, Any?>?) : SdkClient(options) {

  constructor() : this(null)


  /**
   * Returns a detokenize entity bound to this client.
   * Idiomatic usage: client.detokenize(null).list(null, null) or
   * client.detokenize(null).load(mutableMapOf("id" to ...), null).
   */
  fun detokenize(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.bluefinshieldconexsdk.entity.DetokenizeEntity(this, entopts)
  }

  /**
   * Returns a tokenize entity bound to this client.
   * Idiomatic usage: client.tokenize(null).list(null, null) or
   * client.tokenize(null).load(mutableMapOf("id" to ...), null).
   */
  fun tokenize(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.bluefinshieldconexsdk.entity.TokenizeEntity(this, entopts)
  }

  /**
   * Returns a tokenize_batch entity bound to this client.
   * Idiomatic usage: client.tokenizeBatch(null).list(null, null) or
   * client.tokenizeBatch(null).load(mutableMapOf("id" to ...), null).
   */
  fun tokenizeBatch(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.bluefinshieldconexsdk.entity.TokenizeBatchEntity(this, entopts)
  }

  /**
   * Returns a tokenize_read entity bound to this client.
   * Idiomatic usage: client.tokenizeRead(null).list(null, null) or
   * client.tokenizeRead(null).load(mutableMapOf("id" to ...), null).
   */
  fun tokenizeRead(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.bluefinshieldconexsdk.entity.TokenizeReadEntity(this, entopts)
  }

  /**
   * Returns a validate entity bound to this client.
   * Idiomatic usage: client.validate(null).list(null, null) or
   * client.validate(null).load(mutableMapOf("id" to ...), null).
   */
  fun validate(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.bluefinshieldconexsdk.entity.ValidateEntity(this, entopts)
  }


  companion object {
    // testSDK builds a client in test mode: the test feature is activated,
    // installing the in-memory mock transport (no network activity).
    fun testSDK(): BluefinShieldconexSDK = testSDK(null, null)

    fun testSDK(
      testopts: MutableMap<String, Any?>?,
      sdkopts: MutableMap<String, Any?>?,
    ): BluefinShieldconexSDK {
      val sdk = BluefinShieldconexSDK(testOptions(testopts, sdkopts))
      sdk.mode = "test"
      return sdk
    }
  }
}
