package schedule_test

import (
	"testing"

	"github.com/stretchr/testify/assert"

	"github.com/xkamail/tidaltech/pkg/schedule"
)

func TestDay(t *testing.T) {
	t.Parallel()

	t.Run("everyday", func(t *testing.T) {
		d := schedule.Everyday
		assert.Len(t, d.String(), 7)
		assert.Equal(t, "0000000",
			d.String(),
			"everyday should be 0000000",
		)
	})

	t.Run("monday", func(t *testing.T) {
		d := schedule.Monday
		assert.Len(t, d.String(), 7)
		assert.Equal(t, "0100000",
			d.String(),
		)
	})
	t.Run("tuesday", func(t *testing.T) {
		d := schedule.Tuesday
		assert.Len(t, d.String(), 7)
		assert.Equal(t, "0010000",
			d.String(),
		)
	})
	t.Run("wednesday", func(t *testing.T) {
		d := schedule.Wednesday
		assert.Len(t, d.String(), 7)
		assert.Equal(t, "0001000",
			d.String(),
		)
	})
	t.Run("thursday", func(t *testing.T) {
		d := schedule.Thursday
		assert.Len(t, d.String(), 7)
		assert.Equal(t, "0000100",
			d.String(),
		)
	})
	t.Run("friday", func(t *testing.T) {
		d := schedule.Friday
		assert.Len(t, d.String(), 7)
		assert.Equal(t, "0000010",
			d.String(),
		)
	})
	t.Run("saturday", func(t *testing.T) {
		d := schedule.Saturday
		assert.Len(t, d.String(), 7)
		assert.Equal(t, "0000001",
			d.String(),
		)
	})
	t.Run("sunday", func(t *testing.T) {
		t.Skipf("sunday is not supported yet")
		d := schedule.Sunday
		assert.Len(t, d.String(), 7)
		assert.Equal(t, "1000000",
			d.String(),
		)
	})
	t.Run("monday and friday", func(t *testing.T) {
		d := schedule.Monday | schedule.Friday
		assert.Len(t, d.String(), 7)
		assert.Equal(t, "0100010",
			d.String(),
		)
	})

}
