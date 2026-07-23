// Typed models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import "encoding/json"

// Detokenize is the typed data model for the detokenize entity.
type Detokenize struct {
	Batch *[]any `json:"batch,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	Value *[]any `json:"value,omitempty"`
}

// DetokenizeListMatch is the typed request payload for Detokenize.ListTyped.
type DetokenizeListMatch struct {
	Batch *[]any `json:"batch,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	Value *[]any `json:"value,omitempty"`
}

// DetokenizeCreateData is the typed request payload for Detokenize.CreateTyped.
type DetokenizeCreateData struct {
	Batch *[]any `json:"batch,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	Value *[]any `json:"value,omitempty"`
}

// Tokenize is the typed data model for the tokenize entity.
type Tokenize struct {
	Batch *[]any `json:"batch,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	TemplateRef string `json:"template_ref"`
	Value *[]any `json:"value,omitempty"`
}

// TokenizeListMatch is the typed request payload for Tokenize.ListTyped.
type TokenizeListMatch struct {
	Batch *[]any `json:"batch,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	TemplateRef *string `json:"template_ref,omitempty"`
	Value *[]any `json:"value,omitempty"`
}

// TokenizeCreateData is the typed request payload for Tokenize.CreateTyped.
type TokenizeCreateData struct {
	Batch *[]any `json:"batch,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	TemplateRef string `json:"template_ref"`
	Value *[]any `json:"value,omitempty"`
}

// TokenizeBatch is the typed data model for the tokenize_batch entity.
type TokenizeBatch struct {
	Batch *[]any `json:"batch,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	Reference *string `json:"reference,omitempty"`
}

// TokenizeBatchCreateData is the typed request payload for TokenizeBatch.CreateTyped.
type TokenizeBatchCreateData struct {
	Batch *[]any `json:"batch,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	Reference *string `json:"reference,omitempty"`
}

// TokenizeRead is the typed data model for the tokenize_read entity.
type TokenizeRead struct {
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	Reference *string `json:"reference,omitempty"`
	State *map[string]any `json:"state,omitempty"`
	Value *[]any `json:"value,omitempty"`
}

// TokenizeReadCreateData is the typed request payload for TokenizeRead.CreateTyped.
type TokenizeReadCreateData struct {
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	Reference *string `json:"reference,omitempty"`
	State *map[string]any `json:"state,omitempty"`
	Value *[]any `json:"value,omitempty"`
}

// Validate is the typed data model for the validate entity.
type Validate struct {
	MessageId *string `json:"message_id,omitempty"`
	Reference *string `json:"reference,omitempty"`
	TemplateRef string `json:"template_ref"`
}

// ValidateCreateData is the typed request payload for Validate.CreateTyped.
type ValidateCreateData struct {
	MessageId *string `json:"message_id,omitempty"`
	Reference *string `json:"reference,omitempty"`
	TemplateRef string `json:"template_ref"`
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedFrom decodes a runtime value (a map[string]any produced by the op
// pipeline) into a typed model T via a JSON round-trip. On any error it
// returns the zero value of T; the op's own (value, error) tuple carries the
// real error.
func typedFrom[T any](v any) T {
	var out T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value ([]any of maps) into a typed
// slice []T via a JSON round-trip, for list ops.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
