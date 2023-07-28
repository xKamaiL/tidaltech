package lighting

import (
	"reflect"
	"testing"
)

func TestTimeSchedule_ListPoint(t *testing.T) {
	type fields struct {
		Points []TimePoint
	}
	tests := []struct {
		name   string
		fields fields
		want   []TimePoint
	}{
		{
			name: "test 1",
			fields: fields{
				Points: []TimePoint{
					{
						Hour:   7,
						Minute: 30,
					},
					{
						Hour:   6,
						Minute: 30,
					},
				},
			},
			want: []TimePoint{
				{
					Hour:   6,
					Minute: 30,
				},
				{
					Hour:   7,
					Minute: 30,
				},
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			ts := TimeSchedule{
				Points: tt.fields.Points,
			}
			if got := ts.ListPoint(); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("ListPoint() = %v, want %v", got, tt.want)
			}
		})
	}
}
