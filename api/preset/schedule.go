package preset

import (
	"context"
	"time"

	"github.com/acoshift/pgsql"
	"github.com/acoshift/pgsql/pgctx"
	"github.com/google/uuid"

	"github.com/xkamail/tidaltech/api/auth"
	"github.com/xkamail/tidaltech/pkg/schedule"
)

type Preset struct {
	ID          uuid.UUID             `json:"id"`
	Name        string                `json:"name"`
	Description string                `json:"description"`
	TimePoints  []*schedule.TimePoint `json:"timePoints"`
	CreatedAt   time.Time             `json:"createdAt"`
}

type ListResult struct {
	Items []*Preset `json:"items"`
}

func ListPublic(ctx context.Context) (*ListResult, error) {
	return &ListResult{}, nil
}

func List(ctx context.Context) (*ListResult, error) {
	userID := auth.GetAccountID(ctx)

	result := make([]*Preset, 0)

	err := pgctx.Iter(ctx, func(scan pgsql.Scanner) error {
		var p Preset
		err := scan(&p.ID, &p.Name, &p.Description, pgsql.JSON(&p.TimePoints), &p.CreatedAt)
		if err != nil {
			return err
		}
		result = append(result, &p)
		return nil
	}, `select id, name,description,time_points,created_at 
			from schedule_presets 
			where user_id = $1 order by created_at desc`,
		userID,
	)
	if err != nil {
		return nil, err
	}
	return &ListResult{
		Items: result,
	}, nil
}

type CreateResult struct {
	ID uuid.UUID `json:"id"`
}
type CreateParam struct {
	Name       string                `json:"name"`
	TimePoints []*schedule.TimePoint `json:"timePoints"`
}

func Create(ctx context.Context, p *CreateParam) (*CreateResult, error) {
	userID := auth.GetAccountID(ctx)

	_, err := pgctx.Exec(ctx, `insert into schedule_presets (id, user_id, name, description, time_points)
    		values ($1, $2, $3, $4, $5)`,
		uuid.New(),
		userID,
		p.Name,
		"",
		p.TimePoints,
	)
	if err != nil {
		return nil, err
	}

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
