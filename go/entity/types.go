// Typed models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import (
	"encoding/json"

	"github.com/voxgig-sdk/bluefin-shieldconex-sdk/go/core"
)

// Detokenize is the typed data model for the detokenize entity.
type Detokenize struct {
	Batches *[]any `json:"batches,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"messageId,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	Value *string `json:"value,omitempty"`
	Values *[]any `json:"values,omitempty"`
}

// DetokenizeListMatch is the typed request payload for Detokenize.ListTyped.
type DetokenizeListMatch struct {
	Batches *[]any `json:"batches,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"messageId,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	Value *string `json:"value,omitempty"`
	Values *[]any `json:"values,omitempty"`
}

// DetokenizeCreateData is the typed request payload for Detokenize.CreateTyped.
type DetokenizeCreateData struct {
	Batches *[]any `json:"batches,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"messageId,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	Value *string `json:"value,omitempty"`
	Values *[]any `json:"values,omitempty"`
}

// Tokenize is the typed data model for the tokenize entity.
type Tokenize struct {
	Batches *[]any `json:"batches,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"messageId,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	TemplateRef string `json:"templateRef"`
	Value *string `json:"value,omitempty"`
	Values *[]any `json:"values,omitempty"`
}

// TokenizeListMatch is the typed request payload for Tokenize.ListTyped.
type TokenizeListMatch struct {
	Batches *[]any `json:"batches,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"messageId,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	TemplateRef *string `json:"templateRef,omitempty"`
	Value *string `json:"value,omitempty"`
	Values *[]any `json:"values,omitempty"`
}

// TokenizeCreateData is the typed request payload for Tokenize.CreateTyped.
type TokenizeCreateData struct {
	Batches *[]any `json:"batches,omitempty"`
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"messageId,omitempty"`
	Name *string `json:"name,omitempty"`
	Reference *string `json:"reference,omitempty"`
	TemplateRef string `json:"templateRef"`
	Value *string `json:"value,omitempty"`
	Values *[]any `json:"values,omitempty"`
}

// TokenizeBatch is the typed data model for the tokenize_batch entity.
type TokenizeBatch struct {
	Batches *[]any `json:"batches,omitempty"`
	MessageId *string `json:"messageId,omitempty"`
	Reference *string `json:"reference,omitempty"`
}

// TokenizeBatchCreateData is the typed request payload for TokenizeBatch.CreateTyped.
type TokenizeBatchCreateData struct {
	Batches *[]any `json:"batches,omitempty"`
	MessageId *string `json:"messageId,omitempty"`
	Reference *string `json:"reference,omitempty"`
}

// TokenizeRead is the typed data model for the tokenize_read entity.
type TokenizeRead struct {
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"messageId,omitempty"`
	Reference *string `json:"reference,omitempty"`
	State *map[string]any `json:"state,omitempty"`
	Values *[]any `json:"values,omitempty"`
}

// TokenizeReadCreateData is the typed request payload for TokenizeRead.CreateTyped.
type TokenizeReadCreateData struct {
	Bfid *string `json:"bfid,omitempty"`
	MessageId *string `json:"messageId,omitempty"`
	Reference *string `json:"reference,omitempty"`
	State *map[string]any `json:"state,omitempty"`
	Values *[]any `json:"values,omitempty"`
}

// Validate is the typed data model for the validate entity.
type Validate struct {
	MessageId *string `json:"messageId,omitempty"`
	Reference *string `json:"reference,omitempty"`
	TemplateRef string `json:"templateRef"`
}

// ValidateCreateData is the typed request payload for Validate.CreateTyped.
type ValidateCreateData struct {
	MessageId *string `json:"messageId,omitempty"`
	Reference *string `json:"reference,omitempty"`
	TemplateRef string `json:"templateRef"`
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

// entityData unwraps an entity to its data map.
//
// Operations resolve to the ENTITY, not the raw data (see AGENTS.md), and an
// entity's fields are UNEXPORTED — marshalling one directly yields `{}`, so
// every typed accessor would silently hand back a zero-valued struct. The
// typed boundary therefore takes the data hop first.
func entityData(v any) any {
	if ent, ok := v.(core.Entity); ok {
		return ent.Data()
	}
	return v
}

// typedFrom decodes a runtime value (an entity, or the map[string]any the op
// pipeline produced) into a typed model T via a JSON round-trip. On any error
// it returns the zero value of T; the op's own (value, error) tuple carries
// the real error.
func typedFrom[T any](v any) T {
	var out T
	v = entityData(v)
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

// typedSliceFrom decodes a runtime list value into a typed slice []T via a
// JSON round-trip, for list ops. `list` resolves to a slice of ENTITY
// instances, so each element takes the data hop.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	if list, ok := v.([]any); ok {
		unwrapped := make([]any, 0, len(list))
		for _, item := range list {
			unwrapped = append(unwrapped, entityData(item))
		}
		v = unwrapped
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
