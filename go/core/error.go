package core

type BluefinShieldconexError struct {
	IsBluefinShieldconexError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewBluefinShieldconexError(code string, msg string, ctx *Context) *BluefinShieldconexError {
	return &BluefinShieldconexError{
		IsBluefinShieldconexError: true,
		Sdk:              "BluefinShieldconex",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *BluefinShieldconexError) Error() string {
	return e.Msg
}
