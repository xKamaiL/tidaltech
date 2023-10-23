package schedule

type Day int

const (
	_ Day = 1 << iota
	Monday
	Tuesday
	Wednesday
	Thursday
	Friday
	Saturday
	Sunday
)

const (
	// Everyday = 0000000
	// turn on every day
	Everyday Day = iota
	// Weekday turn on every weekday
	Weekday = Monday | Tuesday | Wednesday | Thursday | Friday

	Weekend = Saturday | Sunday
)

func (d Day) String() string {
	if d == Everyday {
		return "0000000"
	}
	// convert to binary
	b := []byte("0000000") // 7 bits initialized to 0 (turn on)
	for i := 0; i < 7; i++ {
		if d&(1<<i) == 0 {
			b[i] = '0'
		} else {
			b[i] = '1'
		}
	}
	return string(b)
}
