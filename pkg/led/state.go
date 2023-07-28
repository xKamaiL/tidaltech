package led

// State of the lighting system.
// The following LED colors are supported:
type State struct {
	White       uint8 `json:"white"`
	RoyalBlue   uint8 `json:"royalBlue"`
	Red         uint8 `json:"red"`
	Green       uint8 `json:"green"`
	WarmWhite   uint8 `json:"warmWhite"`
	UltraViolet uint8 `json:"ultraViolet"`
	Blue        uint8 `json:"blue"`
}
