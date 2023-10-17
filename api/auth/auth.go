package auth

import (
	"context"
	"database/sql"
	"errors"
	"time"

	"github.com/acoshift/pgsql/pgctx"
	"github.com/google/uuid"
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

type SignOutParam struct {
	Token string `json:"token"`
}

func SignOut(ctx context.Context, p *SignOutParam) (err error) {
	userID := GetAccountID(ctx)
	// language=SQL
	_, err = pgctx.Exec(ctx, `
			delete from user_auth_tokens where user_id = $1 and token = $2`,
		userID,
		HashToken(p.Token),
	)
	return nil
}

type ProfileResult struct {
	ID        uuid.UUID `json:"id"`
	Email     string    `json:"email"`
	CreatedAt time.Time `json:"createdAt"`
}

func Me(ctx context.Context) (*ProfileResult, error) {
	userID := GetAccountID(ctx)
	var r ProfileResult
	// language=SQL
	err := pgctx.QueryRow(ctx, `
		select id, email, created_at
			from users
			where id = $1`,
		userID,
	).Scan(
		&r.ID,
		&r.Email,
		&r.CreatedAt,
	)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrProfileNotFound
	}
	if err != nil {
		return nil, err
	}
	return &r, nil
}
