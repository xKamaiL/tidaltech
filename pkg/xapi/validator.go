package xapi

import (
	"encoding/json"

	"github.com/moonrhythm/validator"
)

type ValidatorError struct {
	e validator.Error
}

func (e ValidatorError) Error() string {
	return e.e.Error()
}

func (e ValidatorError) OKError() {
}

func (e ValidatorError) MarshalJSON() ([]byte, error) {
	type x struct {
		Field   []string `json:"field"`
		Message string   `json:"message"`
		Code    string   `json:"code"`
	}

	return json.Marshal(x{
		Field:   e.e.Strings(),
		Message: "validation error",
		Code:    "VALIDATION_ERROR",
	})
}
