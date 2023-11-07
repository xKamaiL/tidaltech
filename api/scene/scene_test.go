package scene_test

import (
	"testing"

	"github.com/stretchr/testify/assert"

	"github.com/xkamail/tidaltech/api/scene"
	"github.com/xkamail/tidaltech/pkg/ts"
)

func TestList(t *testing.T) {

	t.Run("ok", func(t *testing.T) {
		tc := ts.New()
		defer tc.Teardown()
		ctx := tc.Ctx()

		list, err := scene.List(ctx)
		if !assert.NoError(t, err) {
			return
		}

		assert.Len(t, list.Items, 1)
	})

}
