package preset_test

import (
	"testing"

	"github.com/stretchr/testify/assert"

	"github.com/xkamail/tidaltech/api/auth"
	"github.com/xkamail/tidaltech/api/preset"
	"github.com/xkamail/tidaltech/pkg/ts"
)

func TestCreate(t *testing.T) {
	t.Parallel()

	t.Run("ok", func(t *testing.T) {
		tc := ts.New()
		defer tc.Teardown()
	})
}

func TestList(t *testing.T) {
	t.Parallel()

	t.Run("ok", func(t *testing.T) {
		tc := ts.New()
		defer tc.Teardown()
		ctx := tc.Ctx()
		ctx = auth.NewAccountIDContext(ctx, tc.AccountID)
		list, err := preset.List(ctx)
		if !assert.NoError(t, err) {
			return
		}
		assert.Len(t, list.Items, 1)
	})
}
