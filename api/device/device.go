package device

import (
	"context"
	"database/sql"
	"errors"
	"time"

	"github.com/acoshift/arpc/v2"
	"github.com/acoshift/pgsql"
	"github.com/acoshift/pgsql/pgctx"
	"github.com/acoshift/pgsql/pgstmt"
	"github.com/google/uuid"

	"github.com/xkamail/tidaltech/api/auth"
)

var (
	ErrNotFound = arpc.NewErrorCode("DEVICE_NOT_FOUND", "device: device not found")
)

type ListItem struct {
	ID        uuid.UUID `json:"id"`
	Name      string    `json:"name"`
	CreatedAt time.Time `json:"createdAt"`
}
type ListResult struct {
	Item []*ListItem `json:"item"`
}

func List(ctx context.Context) (*ListResult, error) {
	userID := auth.GetAccountID(ctx)

	var result ListResult

	err := pgstmt.Select(func(b pgstmt.SelectStatement) {
		b.Columns("id", "name", "created_at")
		b.Where(func(b pgstmt.Cond) {
			b.Mode().And()
			b.Eq("pair_user_id", userID)
		})
	}).IterWith(ctx, func(scan pgsql.Scanner) error {
		var x ListItem
		if err := scan(
			&x.ID,
			&x.Name,
			&x.CreatedAt,
		); err != nil {
			return err
		}

		result.Item = append(result.Item, &x)
		return nil
	})
	if err != nil {
		return nil, err
	}
	return &result, nil
}

type GetParam struct {
	ID uuid.UUID `json:"id"`
}

type Device struct {
	ID         uuid.UUID  `json:"id"`
	Name       string     `json:"name"`
	PairUserID uuid.UUID  `json:"pairUserId"`
	PairAt     time.Time  `json:"pairAt"`
	Properties Properties `json:"properties"`
	CreatedAt  time.Time  `json:"createdAt"`
}

func Get(ctx context.Context, p *GetParam) (*Device, error) {
	userID := auth.GetAccountID(ctx)
	var d Device
	err := pgctx.QueryRow(ctx, `select * from devices where pair_user_id = $1 and id = $2`,
		userID,
		p.ID,
	).Scan(
		&d.ID,
		&d.Name,
		&d.PairUserID,
		&d.PairAt,
		pgsql.JSON(&d.Properties),
		&d.CreatedAt,
	)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}

	return &d, nil
}

type PairParam struct {
}

func Pair(ctx context.Context, p *PairParam) error {
	panic("not implemented")
}

type UnPairParam struct {
}

func UnPair(ctx context.Context, p *UnPairParam) error {
	panic("not implemented")
}
