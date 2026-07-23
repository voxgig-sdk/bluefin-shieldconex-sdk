// Typed reference models for the BluefinShieldconex SDK (C++).
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params. The C++ SDK runtime is Value-based, so these structs are
// DOCUMENTATION / convenience types only — the SDK neither includes nor
// requires this header. Array fields surface as std::vector<Value>, object
// fields as std::map<std::string, Value>, and any/null fields as sdk::Value.
// Optional (req:false) members are flagged with a trailing "// optional"
// comment. Do not edit by hand.

#ifndef SDK_BLUEFINSHIELDCONEX_TYPES_HPP
#define SDK_BLUEFINSHIELDCONEX_TYPES_HPP

#include <cstdint>
#include <map>
#include <string>
#include <vector>

#include "core/types.hpp"

namespace sdk {
namespace types {

struct Detokenize {
  std::vector<Value> batch;  // optional
  std::string bfid;  // optional
  std::string message_id;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::vector<Value> value;  // optional
};

struct DetokenizeListMatch {
  std::vector<Value> batch;  // optional
  std::string bfid;  // optional
  std::string message_id;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::vector<Value> value;  // optional
};

struct DetokenizeCreateData {
  std::vector<Value> batch;  // optional
  std::string bfid;  // optional
  std::string message_id;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::vector<Value> value;  // optional
};

struct Tokenize {
  std::vector<Value> batch;  // optional
  std::string bfid;  // optional
  std::string message_id;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::string template_ref;
  std::vector<Value> value;  // optional
};

struct TokenizeListMatch {
  std::vector<Value> batch;  // optional
  std::string bfid;  // optional
  std::string message_id;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::string template_ref;  // optional
  std::vector<Value> value;  // optional
};

struct TokenizeCreateData {
  std::vector<Value> batch;  // optional
  std::string bfid;  // optional
  std::string message_id;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::string template_ref;
  std::vector<Value> value;  // optional
};

struct TokenizeBatch {
  std::vector<Value> batch;  // optional
  std::string message_id;  // optional
  std::string reference;  // optional
};

struct TokenizeBatchCreateData {
  std::vector<Value> batch;  // optional
  std::string message_id;  // optional
  std::string reference;  // optional
};

struct TokenizeRead {
  std::string bfid;  // optional
  std::string message_id;  // optional
  std::string reference;  // optional
  std::map<std::string, Value> state;  // optional
  std::vector<Value> value;  // optional
};

struct TokenizeReadCreateData {
  std::string bfid;  // optional
  std::string message_id;  // optional
  std::string reference;  // optional
  std::map<std::string, Value> state;  // optional
  std::vector<Value> value;  // optional
};

struct Validate {
  std::string message_id;  // optional
  std::string reference;  // optional
  std::string template_ref;
};

struct ValidateCreateData {
  std::string message_id;  // optional
  std::string reference;  // optional
  std::string template_ref;
};

} // namespace types
} // namespace sdk

#endif // SDK_BLUEFINSHIELDCONEX_TYPES_HPP
