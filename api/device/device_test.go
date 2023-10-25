package device_test

import (
	"testing"

	"github.com/google/uuid"
	"github.com/stretchr/testify/assert"

	"github.com/xkamail/tidaltech/api/auth"
	"github.com/xkamail/tidaltech/api/device"
	"github.com/xkamail/tidaltech/pkg/ts"
)

func TestPairUnPair(t *testing.T) {
	t.Parallel()

	t.Run("ok", func(t *testing.T) {
		t.Parallel()
		tc := ts.New()
		ctx := tc.Ctx()
		defer tc.Teardown()

		ctx = auth.NewAccountIDContext(ctx, uuid.MustParse("00000000-0000-0000-0000-000000000001"))

		//
		list, err := device.List(ctx)
		if !assert.NoError(t, err) {
			return
		}
		assert.Len(t, list.Items, 0)

		err = device.Pair(
			ctx,
			&device.PairParam{ID: uuid.MustParse("83ac6d47-82fd-403a-b903-1a7df6248d46")},
		)
		if assert.NoError(t, err) {
			return
		}

		list, err = device.List(ctx)
		if !assert.NoError(t, err) {
			return
		}
		assert.Len(t, list.Items, 1)

		for _, item := range list.Items {
			assert.Equal(t, "83ac6d47-82fd-403a-b903-1a7df6248d46", item.ID.String())
			assert.Equal(t, "TIDAL TECH LIGHTING", item.Name)
		}

		err = device.UnPair(
			ctx,
			&device.UnPairParam{ID: uuid.MustParse("83ac6d47-82fd-403a-b903-1a7df6248d46")},
		)
		if assert.NoError(t, err) {
			return
		}

		//

		list, err = device.List(ctx)
		if !assert.NoError(t, err) {
			return
		}
		assert.Len(t, list.Items, 0)
	})

}
