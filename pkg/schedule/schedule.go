package schedule

import (
	"github.com/xkamail/tidaltech/pkg/led"
)

type Schedule struct {
	Points  []*TimePoint `json:"points"`
	Weekday Day          `json:"weekday"`
}

type TimePoint struct {
	// Time in hh:mm
	Time       string                  `json:"time"`
	Brightness map[led.Color]led.Level `json:"brightness"`
}
