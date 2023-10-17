package auth

import (
	"context"

	"github.com/moonrhythm/validator"
)

type SignInParam struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

func (p *SignInParam) Valid() error {
	v := validator.New()
	v.Must(len(p.Email) > 0, "email is required")
	v.Must(len(p.Password) > 0, "password is required")
	return v.Error()
}

type SignInResult struct {
	Token string `json:"token"`
}

func SignIn(ctx context.Context, p *SignInParam) (SignInResult, error) {

	return SignInResult{
		"token",
	}, nil
}
