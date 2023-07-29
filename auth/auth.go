package auth

import (
	"context"
	"strings"

	"github.com/asaskevich/govalidator"
	"github.com/moonrhythm/validator"
)

type SignInParam struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

func (p *SignInParam) Valid() error {
	v := validator.New()
	p.Username = strings.TrimSpace(p.Username)
	p.Password = strings.TrimSpace(p.Password)

	v.Must(p.Username != "", "username required")
	v.Must(len(p.Username) > 4, "username must be at least 4 characters")
	v.Must(govalidator.IsAlphanumeric(p.Username), "username must be alphanumeric")
	v.Must(p.Password != "", "password required")
	v.Must(len(p.Password) > 6, "password must be at least 6 characters")
	return v.Error()
}

func SignIn(ctx context.Context, p *SignInParam) {

}

type SignUpParam struct {
	Username        string `json:"username"`
	Password        string `json:"password"`
	ConfirmPassword string `json:"confirmPassword"`
	Email           string `json:"email"`
}

func (p *SignUpParam) Valid() error {
	v := validator.New()
	p.Username = strings.TrimSpace(p.Username)
	p.Password = strings.TrimSpace(p.Password)
	p.ConfirmPassword = strings.TrimSpace(p.ConfirmPassword)
	p.Email = strings.TrimSpace(p.Email)

	v.Must(govalidator.IsEmail(p.Email), "email is invalid")
	v.Must(p.Username != "", "username required")
	v.Must(len(p.Username) > 4, "username must be at least 4 characters")
	v.Must(govalidator.IsAlphanumeric(p.Username), "username must be alphanumeric")
	v.Must(p.Password != "", "password required")
	v.Must(len(p.Password) > 6, "password must be at least 6 characters")
	return v.Error()
}

func SignUp(ctx context.Context) {

}
