package device

import "github.com/xkamail/tidaltech/pkg/led"

type Mode uint8

const (
	ModeSchedule Mode = iota
	ModeManual
)

type Date string

type Properties struct {
	Power    bool     `json:"power"`
	Mode     Mode     `json:"mode"`
	Schedule Schedule `json:"schedule"`
}

type Schedule struct {
	Points []*TimePoint `json:"points"`
}

type TimePoint struct {
	// Time in hh:mm
	Time       string                  `json:"time"`
	Brightness map[led.Color]led.Level `json:"brightness"`
}
