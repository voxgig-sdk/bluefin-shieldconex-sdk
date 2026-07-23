package voxgig.bluefinshieldconexsdk.core;

import java.util.Map;

/**
 * BluefinShieldconex SDK client. All transport and pipeline behaviour lives in
 * the SdkClient base (core/SdkClient.java); this class binds the
 * API-specific entity accessors and the test-mode constructor.
 */
public class BluefinShieldconexSDK extends SdkClient {

  public BluefinShieldconexSDK() {
    this(null);
  }

  public BluefinShieldconexSDK(Map<String, Object> options) {
    super(options);
  }


  /**
   * Returns a detokenize entity bound to this client.
   * Idiomatic usage: client.detokenize(null).list(null, null) or
   * client.detokenize(null).load(Map.of("id", ...), null).
   */
  public SdkEntity detokenize(Map<String, Object> entopts) {
    return new voxgig.bluefinshieldconexsdk.entity.DetokenizeEntity(this, entopts);
  }

  /**
   * Returns a tokenize entity bound to this client.
   * Idiomatic usage: client.tokenize(null).list(null, null) or
   * client.tokenize(null).load(Map.of("id", ...), null).
   */
  public SdkEntity tokenize(Map<String, Object> entopts) {
    return new voxgig.bluefinshieldconexsdk.entity.TokenizeEntity(this, entopts);
  }

  /**
   * Returns a tokenize_batch entity bound to this client.
   * Idiomatic usage: client.tokenizeBatch(null).list(null, null) or
   * client.tokenizeBatch(null).load(Map.of("id", ...), null).
   */
  public SdkEntity tokenizeBatch(Map<String, Object> entopts) {
    return new voxgig.bluefinshieldconexsdk.entity.TokenizeBatchEntity(this, entopts);
  }

  /**
   * Returns a tokenize_read entity bound to this client.
   * Idiomatic usage: client.tokenizeRead(null).list(null, null) or
   * client.tokenizeRead(null).load(Map.of("id", ...), null).
   */
  public SdkEntity tokenizeRead(Map<String, Object> entopts) {
    return new voxgig.bluefinshieldconexsdk.entity.TokenizeReadEntity(this, entopts);
  }

  /**
   * Returns a validate entity bound to this client.
   * Idiomatic usage: client.validate(null).list(null, null) or
   * client.validate(null).load(Map.of("id", ...), null).
   */
  public SdkEntity validate(Map<String, Object> entopts) {
    return new voxgig.bluefinshieldconexsdk.entity.ValidateEntity(this, entopts);
  }


  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  public static BluefinShieldconexSDK testSDK() {
    return testSDK(null, null);
  }

  public static BluefinShieldconexSDK testSDK(
      Map<String, Object> testopts, Map<String, Object> sdkopts) {
    BluefinShieldconexSDK sdk = new BluefinShieldconexSDK(SdkClient.testOptions(testopts, sdkopts));
    sdk.mode = "test";
    return sdk;
  }
}
