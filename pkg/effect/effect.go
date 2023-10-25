package effect

import "github.com/xkamail/tidaltech/pkg/led"

type Timeline struct {
	Duration uint      `json:"duration"`
	Color    led.Color `json:"color"`
}
