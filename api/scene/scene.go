package scene

import (
	"context"
	"database/sql"
	"errors"
	"strings"
	"time"

	"github.com/acoshift/arpc/v2"
	"github.com/acoshift/pgsql"
	"github.com/acoshift/pgsql/pgctx"
	"github.com/moonrhythm/validator"

	"github.com/xkamail/tidaltech/pkg/effect"
)

var (
	ErrNotFound = arpc.NewErrorCode("SCENE_NOT_FOUND", "scene: not found")
)

type Scene struct {
	ID   string `json:"id"`
	Name string `json:"name"`
	// Icon according to https://materialdesignicons.com/
	Icon string `json:"icon"`
	// Colors map of colors and levels
	Timeline  []*effect.Timeline `json:"colors"`
	CreatedAt time.Time          `json:"createdAt"`
}

type ListResult struct {
	Items []*Scene `json:"items"`
}

func List(ctx context.Context) (*ListResult, error) {
	items := make([]*Scene, 0)

	err := pgctx.Iter(ctx, func(scan pgsql.Scanner) error {
		var s Scene

		if err := scan(
			&s.ID,
			&s.Name,
			&s.Icon,
			pgsql.JSON(&s.Timeline),
			&s.CreatedAt,
		); err != nil {
			return err
		}
		items = append(items, &s)

		return nil
	}, `select id, name, icon, data, created_at from scenes order by created_at desc`)
	if err != nil {
		return nil, err
	}

	return &ListResult{
		Items: items,
	}, nil
}

type GetParams struct {
	ID string `json:"id"`
}

func (p *GetParams) Valid() error {
	v := validator.New()
	p.ID = strings.ToLower(p.ID)
	v.Must(len(p.ID) > 0, "id is required")
	return v.Error()
}

func Get(ctx context.Context, p *GetParams) (*Scene, error) {
	var s Scene

	err := pgctx.QueryRow(ctx, `
			select id, name, icon, data, created_at 
			from scenes where id = $1`,
		p.ID,
	).Scan(
		&s.ID,
		&s.Name,
		&s.Icon,
		pgsql.JSON(&s.Timeline),
	)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}
	return &s, nil
}
