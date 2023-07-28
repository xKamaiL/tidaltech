package lighting

type TimeSchedule struct {
	Points []TimePoint `json:"points"`
}

// ListPoint return sorted list of time points
func (ts TimeSchedule) ListPoint() []TimePoint {
	sorted := make([]TimePoint, len(ts.Points))
	copy(sorted, ts.Points)
	for i := 0; i < len(sorted); i++ {
		for j := i + 1; j < len(sorted); j++ {
			if sorted[i].minutes() > sorted[j].minutes() {
				sorted[i], sorted[j] = sorted[j], sorted[i]
			}
		}
	}
	return sorted
}
