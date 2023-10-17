package device

import (
	"encoding/json"

	"github.com/acoshift/arpc/v2"
)

var (
	ErrInvalidMode = arpc.NewErrorCode("INVALID_MODE", "device: invalid mode")
)

type Mode uint8

func (m Mode) MarshalJSON() ([]byte, error) {
	switch m {
	case ModeSchedule:
		return []byte(`"schedule"`), nil
	case ModeManual:
		return []byte(`"manual"`), nil
	default:
		return nil, ErrInvalidMode
	}
}

func (m *Mode) UnmarshalJSON(b []byte) error {
	var s string
	if err := json.Unmarshal(b, &s); err != nil {
		return err
	}

	switch s {
	case "schedule":
		*m = ModeSchedule
	case "manual":
		*m = ModeManual
	default:
		return ErrInvalidMode
	}

	return nil
}

const (
	ModeSchedule Mode = iota
	ModeManual
)

var _ json.Unmarshaler = (*Mode)(nil)
var _ json.Marshaler = (*Mode)(nil)
