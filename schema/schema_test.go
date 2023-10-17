package schema_test

import (
	"testing"

	"github.com/xkamail/tidaltech/pkg/ts"
)

func TestMigrate(t *testing.T) {

	t.Run("migrate", func(t *testing.T) {
		tc := ts.New()
		defer tc.Teardown()
	})

}
