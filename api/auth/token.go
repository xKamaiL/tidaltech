package auth

import (
	"context"
	"crypto/sha1"
	"time"

	"github.com/acoshift/pgsql/pgctx"
	"github.com/google/uuid"
	"github.com/thanhpk/randstr"
)

func HashToken(str string) string {
	h := sha1.New()
	h.Write([]byte(str))
	return string(h.Sum(nil))
}

func GetToken(ctx context.Context, hashedToken string) (userID uuid.UUID, err error) {
	err = pgctx.QueryRow(ctx, `
		select user_id 
			from user_auth_tokens 
			where token = $1 and expires_at > $2 `,
		hashedToken,
		time.Now(),
	).Scan(
		&userID,
	)
	return
}

func insertToken(ctx context.Context, userID uuid.UUID) (token string, err error) {
	token = randstr.Base64(32)
	_, err = pgctx.Exec(ctx, `
		insert into user_auth_tokens (user_id, token, expires_at)
			values ($1, $2, $3) `,
		userID,
		HashToken(token),
		time.Now().Add(24*time.Hour*7),
	)
	return
}

func ClearExpiresToken(ctx context.Context) (err error) {
	// language=SQL
	_, err = pgctx.Exec(ctx, `
		delete from user_auth_tokens
			where expires_at < $1 `,
		time.Now(),
	)
	return
}
