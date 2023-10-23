package preset

import (
	"context"

	"github.com/google/uuid"
)

type Preset struct {
	ID          uuid.UUID `json:"id"`
	Name        string    `json:"name"`
	Description string    `json:"description"`
}

func ListPublic(ctx context.Context) {

}

func List(ctx context.Context) {

}
