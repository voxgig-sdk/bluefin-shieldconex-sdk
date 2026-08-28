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
  voxgig_value*batches;  // optional
  char*bfid;  // optional
  char*messageid;  // optional
  char*name;  // optional
  char*reference;  // optional
  char*value;  // optional
  voxgig_value*values;  // optional
} Detokenize;

// DetokenizeListMatch is the typed request payload for Detokenize.list.
typedef struct {
  char*bfid;
  char*field_name;  // optional
  char*field_value;  // optional
  char*reference;  // optional
} DetokenizeListMatch;

// DetokenizeCreateData is the typed request payload for Detokenize.create.
typedef struct {
  voxgig_value*batches;  // optional
  char*bfid;  // optional
  char*messageid;  // optional
  char*name;  // optional
  char*reference;  // optional
  char*value;  // optional
  voxgig_value*values;  // optional
} DetokenizeCreateData;

// Tokenize is the typed data model for the tokenize entity.
typedef struct {
  voxgig_value*batches;  // optional
  char*bfid;  // optional
  char*messageid;  // optional
  char*name;  // optional
  char*reference;  // optional
  char*templateref;
  char*value;  // optional
  voxgig_value*values;  // optional
} Tokenize;

// TokenizeListMatch is the typed request payload for Tokenize.list.
typedef struct {
  char*field_name;  // optional
  char*field_value;  // optional
  char*reference;  // optional
  char*template_ref;
} TokenizeListMatch;

// TokenizeCreateData is the typed request payload for Tokenize.create.
typedef struct {
  double omit;  // optional
  voxgig_value*batches;  // optional
  char*bfid;  // optional
  char*messageid;  // optional
  char*name;  // optional
  char*reference;  // optional
  char*templateref;
  char*value;  // optional
  voxgig_value*values;  // optional
} TokenizeCreateData;

// TokenizeBatch is the typed data model for the tokenize_batch entity.
typedef struct {
  voxgig_value*batches;  // optional
  char*messageid;  // optional
  char*reference;  // optional
} TokenizeBatch;

// TokenizeBatchCreateData is the typed request payload for TokenizeBatch.create.
typedef struct {
  voxgig_value*batches;  // optional
  char*messageid;  // optional
  char*reference;  // optional
} TokenizeBatchCreateData;

// TokenizeRead is the typed data model for the tokenize_read entity.
typedef struct {
  char*bfid;  // optional
  char*messageid;  // optional
  char*reference;  // optional
  voxgig_value*state;  // optional
  voxgig_value*values;  // optional
} TokenizeRead;

// TokenizeReadCreateData is the typed request payload for TokenizeRead.create.
typedef struct {
  char*bfid;  // optional
  char*messageid;  // optional
  char*reference;  // optional
  voxgig_value*state;  // optional
  voxgig_value*values;  // optional
} TokenizeReadCreateData;

// Validate is the typed data model for the validate entity.
typedef struct {
  char*messageid;  // optional
  char*reference;  // optional
  char*templateref;
} Validate;

// ValidateCreateData is the typed request payload for Validate.create.
typedef struct {
  char*messageid;  // optional
  char*reference;  // optional
  char*templateref;
} ValidateCreateData;

#endif // BLUEFINSHIELDCONEX_ENTITY_TYPES_H
