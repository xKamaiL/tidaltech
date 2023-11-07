package scene_test

import (
	"testing"

	"github.com/stretchr/testify/assert"

	"github.com/xkamail/tidaltech/api/scene"
	"github.com/xkamail/tidaltech/pkg/ts"
)

func TestList(t *testing.T) {
	t.Parallel()

	t.Run("ok", func(t *testing.T) {
		tc := ts.New()
		defer tc.Teardown()
		ctx := tc.Ctx()

		list, err := scene.List(ctx,
			&scene.ListParams{
				Query: []string{},
			},
		)
		if !assert.NoError(t, err) {
			return
		}
		assert.NotEmpty(t, list.Items)
	})
	t.Run("with filter", func(t *testing.T) {
		tc := ts.New()
		defer tc.Teardown()
		ctx := tc.Ctx()

		list, err := scene.List(ctx,
			&scene.ListParams{
				Query: []string{
					"moonlight",
					"thunderstorm",
				},
			},
		)
		if !assert.NoError(t, err) {
			return
		}
		assert.NotEmpty(t, list.Items)
		assert.Len(t, list.Items, 2)
	})
}
