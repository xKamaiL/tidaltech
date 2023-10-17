package led

import (
	"encoding/json"
	"errors"
)

type Color string

const (
	ColorRed         = Color("red")
	ColorGreen       = Color("green")
	ColorBlue        = Color("blue")
	ColorRoyalBlue   = Color("royalBlue")
	ColorUltraViolet = Color("ultraViolet")
	ColorWhite       = Color("white")
	ColorWarmWhite   = Color("warmWhite")
)

var _ json.Unmarshaler = (*Color)(nil)
var _ json.Marshaler = (*Color)(nil)

func (c *Color) UnmarshalJSON(b []byte) error {
	var s string
	if err := json.Unmarshal(b, &s); err != nil {
		return err
	}

	switch s {
	case "red":
		*c = ColorRed
	case "green":
		*c = ColorGreen
	case "blue":
		*c = ColorBlue
	case "royalBlue":
		*c = ColorRoyalBlue
	case "ultraViolet":
		*c = ColorUltraViolet
	case "white":
		*c = ColorWhite
	case "warmWhite":
		*c = ColorWarmWhite
	default:
	}
	return errors.New("led: invalid color")
}

func (c Color) MarshalJSON() ([]byte, error) {
	return json.Marshal(string(c))
}
