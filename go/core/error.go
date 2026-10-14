package core

import "encoding/json"

type BluefinShieldconexError struct {
	IsBluefinShieldconexError bool
	Sdk                string
	Code               string
	Msg                string
	// Reachable for a debugger, invisible to a serialiser: the context holds
	// the live spec and options, and an error is what gets logged.
	Ctx    *Context `json:"-"`
	Result any
	Spec   any
}

func NewBluefinShieldconexError(code string, msg string, ctx *Context) *BluefinShieldconexError {
	return &BluefinShieldconexError{
		IsBluefinShieldconexError: true,
		Sdk:                "BluefinShieldconex",
		Code:               code,
		Msg:                msg,
		Ctx:                ctx,
	}
}

func (e *BluefinShieldconexError) Error() string {
	return e.Msg
}

// What makeError attached is already cleaned; the context is not part of
// the record.
func (e *BluefinShieldconexError) Record() map[string]any {
	return map[string]any{
		"sdk":     e.Sdk,
		"code":    e.Code,
		"message": e.Msg,
		"result":  e.Result,
		"spec":    e.Spec,
	}
}

func (e *BluefinShieldconexError) MarshalJSON() ([]byte, error) {
	return json.Marshal(e.Record())
}
