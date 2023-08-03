package effect

// Effect represents behavior of the LED.
type Effect uint8

const (
	// Fade is an adjusted brightness from zero to max.
	// and then back to zero.
	Fade Effect = iota + 1
	// Flash is an adjusted brightness from zero to max.
	// in a short period of time.
	Flash
	// RandomFlicker is a special effect that is used to simulate fire.
	// It will turn off the LEDs in a random pattern.
	RandomFlicker
	// CloudMovement is a special effect that is used to simulate clouds.
	// It will turn off the LEDs in a random pattern.
	// The brightness of the LEDs will be set to 0.
	CloudMovement
)
