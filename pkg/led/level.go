package led

import (
	"encoding/json"
	"fmt"
)

type Level uint8

const (
	LevelOff Level = iota
	LevelMax       = Level(100)
)

func (l Level) String() string {
	return fmt.Sprintf("%d%%", l)
}

var _ json.Unmarshaler = (*Level)(nil)
var _ json.Marshaler = (*Level)(nil)

func (l *Level) UnmarshalJSON(data []byte) error {
	var x uint8
	if err := json.Unmarshal(data, &x); err != nil {
		return err
	}
	*l = Level(x)
	if *l > LevelMax {
		*l = LevelMax
	}
	if *l < LevelOff {
		*l = LevelOff
	}
	return nil
}

func (l Level) MarshalJSON() ([]byte, error) {
	return json.Marshal(uint8(l))
}
