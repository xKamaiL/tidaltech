package auth_test

import (
	"testing"

	"github.com/google/uuid"
	"github.com/stretchr/testify/assert"

	"github.com/xkamail/tidaltech/api/auth"
	"github.com/xkamail/tidaltech/pkg/ts"
)

func TestSignIn(t *testing.T) {
	t.Parallel()

	t.Run("ok", func(t *testing.T) {
		tc := ts.New()
		defer tc.Teardown()
		ctx := tc.Ctx()
		res, err := auth.SignIn(ctx,
			&auth.SignInParam{
				Email:    "test@email.com",
				Password: "password___",
			},
		)
		if !assert.NoError(t, err) {
			return
		}
		assert.NotNil(t, res)

		t.Parallel()

		t.Run("check token", func(t *testing.T) {
			userID, err := auth.GetToken(ctx, auth.HashToken(res.Token))
			if !assert.NoError(t, err) {
				return
			}
			assert.Equal(t, uuid.MustParse("00000000-0000-0000-0000-000000000001"), userID)
		})

	})

}

func TestSignUp(t *testing.T) {
	t.Parallel()

	t.Run("ok", func(t *testing.T) {
		tc := ts.New()
		defer tc.Teardown()
		ctx := tc.Ctx()
		res, err := auth.SignUp(ctx,
			&auth.SignUpParam{
				Email:           "xkamail@icloud.com",
				Password:        "12345678",
				ConfirmPassword: "12345678",
			},
		)
		if !assert.NoError(t, err) {
			return
		}
		assert.NotNil(t, res)
	})
}
