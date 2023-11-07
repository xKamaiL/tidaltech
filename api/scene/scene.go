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
	"github.com/acoshift/pgsql/pgstmt"
	"github.com/lib/pq"
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

type ListParams struct {
	Query []string `json:"query"`
}

func (p *ListParams) Valid() error {
	v := validator.New()
	for _, q := range p.Query {
		v.Must(len(q) > 0, "query is required")
	}
	return v.Error()
}

func List(ctx context.Context, p *ListParams) (*ListResult, error) {
	if err := p.Valid(); err != nil {
		return nil, err
	}

	items := make([]*Scene, 0)

	filter := func(b pgstmt.Cond) {
		b.Mode().Or()
		if len(p.Query) > 0 {
			b.Or(func(b pgstmt.Cond) {
				b.Eq("id", pgstmt.Any(pq.Array(p.Query)))
			})
		}
	}

	err := pgstmt.Select(func(b pgstmt.SelectStatement) {
		b.From("scenes")
		b.OrderBy("created_at desc")
		b.Columns("id", "name", "icon", "data", "created_at")
		b.Where(filter)
	}).IterWith(ctx, func(scan pgsql.Scanner) error {
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
	})
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
