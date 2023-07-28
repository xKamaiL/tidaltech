package lighting

import (
	"context"
	"time"

	"github.com/google/uuid"

	"github.com/xkamail/tidaltech/pkg/api"
	"github.com/xkamail/tidaltech/pkg/led"
)

type Mode uint8

const (
	ModeAmbient Mode = iota + 1
	ModeFeeding
)

type Device struct {
	ID           uuid.UUID `json:"id"`
	Label        string    `json:"label"`
	PairedUserID uuid.UUID `json:"pairedUserId"`
	Mode         Mode      `json:"mode"`
	// LEDState is the state of the light
	LEDState led.State `json:"ledState"`

	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

func ListDevicesFromUser(ctx context.Context, _ api.Empty) (*[]Device, error) {

	panic("not implemented")
}
