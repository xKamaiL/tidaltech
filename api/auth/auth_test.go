package auth_test

import (
	"testing"

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
	})
	
}
