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

type ListResult struct {
	Items []*Preset `json:"items"`
}

func ListPublic(ctx context.Context) (*ListResult, error) {
	return &ListResult{}, nil
}

func List(ctx context.Context) (*ListResult, error) {
	return &ListResult{}, nil
}

type CreateResult struct {
	ID uuid.UUID `json:"id"`
}
type CreateParam struct {
}

func Create(ctx context.Context, p *CreateParam) (*CreateResult, error) {
	return &CreateResult{}, nil
}

type UpdateParam struct {
	ID uuid.UUID `json:"id"`
}

func Update(ctx context.Context, p *UpdateParam) error {
	return nil
}

type DeleteParam struct {
	ID uuid.UUID `json:"id"`
}

func Delete(ctx context.Context, p *DeleteParam) error {
	return nil
}
