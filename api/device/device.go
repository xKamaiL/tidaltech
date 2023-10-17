package device

import (
	"context"
	"time"

	"github.com/acoshift/pgsql"
	"github.com/acoshift/pgsql/pgstmt"
	"github.com/google/uuid"

	"github.com/xkamail/tidaltech/api/auth"
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

func Get(ctx context.Context, p *GetParam) (*ListItem, error) {
	panic("not implemented")
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
