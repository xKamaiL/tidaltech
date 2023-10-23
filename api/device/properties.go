package device

import "github.com/xkamail/tidaltech/pkg/schedule"

type Date string

type Properties struct {
	Power    bool              `json:"power"`
	Mode     Mode              `json:"mode"`
	Schedule schedule.Schedule `json:"schedule"`
}
