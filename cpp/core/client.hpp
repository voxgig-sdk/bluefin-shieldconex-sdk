// BluefinShieldconex SDK client. All transport and pipeline behaviour lives in the
// SdkClient base (core/types.hpp); this class binds the API-specific entity
// accessors and the test-mode constructor.

#ifndef SDK_CORE_CLIENT_HPP
#define SDK_CORE_CLIENT_HPP

#include <memory>

#include "../core/types.hpp"
#include "../entity/entities.hpp"

namespace sdk {

class BluefinShieldconexSDK : public SdkClient {
public:
  explicit BluefinShieldconexSDK(Value options = Value::undef()) : SdkClient(options) {}


  // Detokenize entity bound to this client.
  std::shared_ptr<DetokenizeEntity> detokenize(Value entopts = Value::undef()) {
    return std::make_shared<DetokenizeEntity>(this, entopts);
  }

  // Tokenize entity bound to this client.
  std::shared_ptr<TokenizeEntity> tokenize(Value entopts = Value::undef()) {
    return std::make_shared<TokenizeEntity>(this, entopts);
  }

  // TokenizeBatch entity bound to this client.
  std::shared_ptr<TokenizeBatchEntity> tokenize_batch(Value entopts = Value::undef()) {
    return std::make_shared<TokenizeBatchEntity>(this, entopts);
  }

  // TokenizeRead entity bound to this client.
  std::shared_ptr<TokenizeReadEntity> tokenize_read(Value entopts = Value::undef()) {
    return std::make_shared<TokenizeReadEntity>(this, entopts);
  }

  // Validate entity bound to this client.
  std::shared_ptr<ValidateEntity> validate(Value entopts = Value::undef()) {
    return std::make_shared<ValidateEntity>(this, entopts);
  }


  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  static std::shared_ptr<BluefinShieldconexSDK> testSDK() {
    return testSDK(Value::undef(), Value::undef());
  }

  static std::shared_ptr<BluefinShieldconexSDK> testSDK(Value testopts, Value sdkopts) {
    auto sdk = std::make_shared<BluefinShieldconexSDK>(SdkClient::testOptions(testopts, sdkopts));
    sdk->mode = "test";
    return sdk;
  }

  // Convenience no-arg constructor.
  static std::shared_ptr<BluefinShieldconexSDK> create() {
    return std::make_shared<BluefinShieldconexSDK>(Value::undef());
  }
};

using BluefinShieldconexSDKPtr = std::shared_ptr<BluefinShieldconexSDK>;

} // namespace sdk

#endif // SDK_CORE_CLIENT_HPP
