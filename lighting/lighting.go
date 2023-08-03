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
	ModeManual Mode = iota + 1
	ModeSchedule
)

type Device struct {
	ID           uuid.UUID      `json:"id"`
	Label        string         `json:"label"`
	PairedUserID uuid.UUID      `json:"pairedUserId"`
	Mode         Mode           `json:"mode"`
	Brightness   led.Brightness `json:"brightness"`
	Schedule     TimeSchedule   `json:"schedule"`

	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

func ListDevicesFromUser(ctx context.Context, _ api.Empty) (*[]Device, error) {

	panic("not implemented")
}
