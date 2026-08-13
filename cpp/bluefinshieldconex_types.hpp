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
  std::vector<Value> batches;  // optional
  std::string bfid;  // optional
  std::string messageId;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::string value;  // optional
  std::vector<Value> values;  // optional
};

struct DetokenizeListMatch {
  std::vector<Value> batches;  // optional
  std::string bfid;  // optional
  std::string messageId;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::string value;  // optional
  std::vector<Value> values;  // optional
};

struct DetokenizeCreateData {
  std::vector<Value> batches;  // optional
  std::string bfid;  // optional
  std::string messageId;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::string value;  // optional
  std::vector<Value> values;  // optional
};

struct Tokenize {
  std::vector<Value> batches;  // optional
  std::string bfid;  // optional
  std::string messageId;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::string templateRef;
  std::string value;  // optional
  std::vector<Value> values;  // optional
};

struct TokenizeListMatch {
  std::vector<Value> batches;  // optional
  std::string bfid;  // optional
  std::string messageId;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::string templateRef;  // optional
  std::string value;  // optional
  std::vector<Value> values;  // optional
};

struct TokenizeCreateData {
  std::vector<Value> batches;  // optional
  std::string bfid;  // optional
  std::string messageId;  // optional
  std::string name;  // optional
  std::string reference;  // optional
  std::string templateRef;
  std::string value;  // optional
  std::vector<Value> values;  // optional
};

struct TokenizeBatch {
  std::vector<Value> batches;  // optional
  std::string messageId;  // optional
  std::string reference;  // optional
};

struct TokenizeBatchCreateData {
  std::vector<Value> batches;  // optional
  std::string messageId;  // optional
  std::string reference;  // optional
};

struct TokenizeRead {
  std::string bfid;  // optional
  std::string messageId;  // optional
  std::string reference;  // optional
  std::map<std::string, Value> state;  // optional
  std::vector<Value> values;  // optional
};

struct TokenizeReadCreateData {
  std::string bfid;  // optional
  std::string messageId;  // optional
  std::string reference;  // optional
  std::map<std::string, Value> state;  // optional
  std::vector<Value> values;  // optional
};

struct Validate {
  std::string messageId;  // optional
  std::string reference;  // optional
  std::string templateRef;
};

struct ValidateCreateData {
  std::string messageId;  // optional
  std::string reference;  // optional
  std::string templateRef;
};

} // namespace types
} // namespace sdk

#endif // SDK_BLUEFINSHIELDCONEX_TYPES_HPP
