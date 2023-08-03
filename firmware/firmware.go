package firmware

import (
	"time"

	"github.com/google/uuid"
)

type Version struct {
	ID          uuid.UUID `json:"id"`
	Version     string    `json:"version"`
	ReleaseNote string    `json:"releaseNote"`
	BinaryURL   string    `json:"-"`
	CreatedAt   time.Time `json:"createdAt"`
	UpdatedAt   time.Time `json:"updatedAt"`
}
