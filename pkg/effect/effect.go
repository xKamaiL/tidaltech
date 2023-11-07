package effect

import "github.com/xkamail/tidaltech/pkg/led"

type Timeline struct {
	Duration uint                    `json:"duration"`
	Color    map[led.Color]led.Level `json:"color"`
}
