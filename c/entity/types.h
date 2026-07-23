// Typed models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return
// `voxgig_value*`), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support. This header is standalone
// and is not #included by any generated .c.

#ifndef BLUEFINSHIELDCONEX_ENTITY_TYPES_H
#define BLUEFINSHIELDCONEX_ENTITY_TYPES_H

#include "sdk.h"

// Detokenize is the typed data model for the detokenize entity.
typedef struct {
  voxgig_value*batch;  // optional
  char*bfid;  // optional
  char*message_id;  // optional
  char*name;  // optional
  char*reference;  // optional
  voxgig_value*value;  // optional
} Detokenize;

// DetokenizeListMatch is the typed request payload for Detokenize.list.
typedef struct {
  voxgig_value*batch;  // optional
  char*bfid;  // optional
  char*message_id;  // optional
  char*name;  // optional
  char*reference;  // optional
  voxgig_value*value;  // optional
} DetokenizeListMatch;

// DetokenizeCreateData is the typed request payload for Detokenize.create.
typedef struct {
  voxgig_value*batch;  // optional
  char*bfid;  // optional
  char*message_id;  // optional
  char*name;  // optional
  char*reference;  // optional
  voxgig_value*value;  // optional
} DetokenizeCreateData;

// Tokenize is the typed data model for the tokenize entity.
typedef struct {
  voxgig_value*batch;  // optional
  char*bfid;  // optional
  char*message_id;  // optional
  char*name;  // optional
  char*reference;  // optional
  char*template_ref;
  voxgig_value*value;  // optional
} Tokenize;

// TokenizeListMatch is the typed request payload for Tokenize.list.
typedef struct {
  voxgig_value*batch;  // optional
  char*bfid;  // optional
  char*message_id;  // optional
  char*name;  // optional
  char*reference;  // optional
  char*template_ref;  // optional
  voxgig_value*value;  // optional
} TokenizeListMatch;

// TokenizeCreateData is the typed request payload for Tokenize.create.
typedef struct {
  voxgig_value*batch;  // optional
  char*bfid;  // optional
  char*message_id;  // optional
  char*name;  // optional
  char*reference;  // optional
  char*template_ref;
  voxgig_value*value;  // optional
} TokenizeCreateData;

// TokenizeBatch is the typed data model for the tokenize_batch entity.
typedef struct {
  voxgig_value*batch;  // optional
  char*message_id;  // optional
  char*reference;  // optional
} TokenizeBatch;

// TokenizeBatchCreateData is the typed request payload for TokenizeBatch.create.
typedef struct {
  voxgig_value*batch;  // optional
  char*message_id;  // optional
  char*reference;  // optional
} TokenizeBatchCreateData;

// TokenizeRead is the typed data model for the tokenize_read entity.
typedef struct {
  char*bfid;  // optional
  char*message_id;  // optional
  char*reference;  // optional
  voxgig_value*state;  // optional
  voxgig_value*value;  // optional
} TokenizeRead;

// TokenizeReadCreateData is the typed request payload for TokenizeRead.create.
typedef struct {
  char*bfid;  // optional
  char*message_id;  // optional
  char*reference;  // optional
  voxgig_value*state;  // optional
  voxgig_value*value;  // optional
} TokenizeReadCreateData;

// Validate is the typed data model for the validate entity.
typedef struct {
  char*message_id;  // optional
  char*reference;  // optional
  char*template_ref;
} Validate;

// ValidateCreateData is the typed request payload for Validate.create.
typedef struct {
  char*message_id;  // optional
  char*reference;  // optional
  char*template_ref;
} ValidateCreateData;

#endif // BLUEFINSHIELDCONEX_ENTITY_TYPES_H
