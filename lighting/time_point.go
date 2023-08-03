package lighting

import "github.com/xkamail/tidaltech/pkg/led"

type TimePoint struct {
	Hour   uint8 `json:"hour"`
	Minute uint8 `json:"minute"`
	// Brightness is the brightness of the light at this time point
	// 0 - off
	// 100 - on
	// default is off
	Brightness led.Brightness `json:"brightness"`
}

// NewTimePoint with hour and minute
func NewTimePoint(hour uint8, mm uint8) *TimePoint {
	return &TimePoint{Hour: hour, Minute: mm}
}

func (tp TimePoint) String() string {
	return string(tp.Hour) + ":" + string(tp.Minute)
}

// minutes return total minutes of this time point
func (tp TimePoint) minutes() int {
	return int(tp.Hour)*60 + int(tp.Minute)
}
