package xapi

import (
	"errors"
	"log/slog"

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

	if e := (*validator.Error)(nil); errors.As(err, &e) {
		return wrapValidateError(err)
	}

	slog.Error("error", "err", err)
	// reveal error
	return Error{err}
}
