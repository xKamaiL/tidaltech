package preset

import (
	"context"
	"strings"
	"time"

	"github.com/acoshift/arpc/v2"
	"github.com/acoshift/pgsql"
	"github.com/acoshift/pgsql/pgctx"
	"github.com/google/uuid"
	"github.com/moonrhythm/validator"

	"github.com/xkamail/tidaltech/api/auth"
	"github.com/xkamail/tidaltech/pkg/schedule"
)

var (
	ErrNotFound = arpc.NewErrorCode("PRESET_NOT_FOUND", "preset: not found")
)

type Preset struct {
	ID          uuid.UUID             `json:"id"`
	Name        string                `json:"name"`
	Description string                `json:"description"`
	TimePoints  []*schedule.TimePoint `json:"timePoints"`
	IsPublic    bool                  `json:"isPublic"`
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
		err := scan(&p.ID, &p.Name, &p.Description, pgsql.JSON(&p.TimePoints), &p.CreatedAt, &p.IsPublic)
		if err != nil {
			return err
		}
		result = append(result, &p)
		return nil
	}, `select id, name, description,time_points,created_at, bool(user_id is null)
			from schedule_presets 
			where (user_id = $1 or user_id is null) order by created_at desc`,
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

func (p *CreateParam) Valid() error {
	v := validator.New()
	p.Name = strings.TrimSpace(p.Name)
	v.Must(p.Name != "", "name is required")
	v.Must(len(p.Name) <= 100, "name is too long")
	v.Must(len(p.TimePoints) > 0, "timePoints is required")
	return v.Error()
}

func Create(ctx context.Context, p *CreateParam) (*CreateResult, error) {
	userID := auth.GetAccountID(ctx)

	_, err := pgctx.Exec(ctx, `insert into schedule_presets (id, user_id, name, description, time_points)
    		values ($1, $2, $3, $4, $5)`,
		uuid.New(),
		userID,
		p.Name,
		"-",
		pgsql.JSON(p.TimePoints),
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
	userID := auth.GetAccountID(ctx)
	r, err := pgctx.Exec(ctx, `delete from schedule_presets where id = $1 and user_id = $2`, p.ID, userID)
	if err != nil {
		return err
	}
	n, err := r.RowsAffected()
	if err != nil {
		return err
	}
	if n == 0 {
		return ErrNotFound
	}
	return nil
}
