package xapi

import (
	"errors"

	"github.com/acoshift/arpc/v2"
	"github.com/moonrhythm/validator"
)

type Empty struct {
}

type Error struct {
	e error
}

func (e Error) Error() string {
	return e.e.Error()
}

func (e Error) OKError() {

}

var _ arpc.OKError = Error{}

func WrapError(err error) error {

	var v validator.Error
	if ok := errors.Is(err, &v); ok {
		return ValidatorError{v}
	}

	// reveal error
	return Error{err}
}
