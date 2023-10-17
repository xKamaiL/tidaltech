package schema_test

import (
	"testing"

	"github.com/stretchr/testify/assert"

	"github.com/xkamail/tidaltech/pkg/ts"
	"github.com/xkamail/tidaltech/schema"
)

func TestMigrate(t *testing.T) {

	t.Run("migrate", func(t *testing.T) {
		tc := ts.New()
		ctx := tc.Ctx()
		defer tc.Teardown()

		err := schema.Migrate(ctx)
		assert.NoError(t, err)
	})

}
