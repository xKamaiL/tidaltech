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
	"github.com/moonrhythm/validator"

	"github.com/xkamail/tidaltech/api/auth"
	"github.com/xkamail/tidaltech/pkg/schedule"
)

var (
	ErrNotFound      = arpc.NewErrorCode("DEVICE_NOT_FOUND", "device: device not found")
	ErrDeviceNotPair = arpc.NewErrorCode("DEVICE_NOT_PAIR", "device: device is not pair")
)

type ListItem struct {
	ID        uuid.UUID `json:"id"`
	Name      string    `json:"name"`
	CreatedAt time.Time `json:"createdAt"`
}
type ListResult struct {
	Items []*ListItem `json:"items"`
}

func List(ctx context.Context) (*ListResult, error) {
	userID := auth.GetAccountID(ctx)

	var result ListResult

	err := pgstmt.Select(func(b pgstmt.SelectStatement) {
		b.Columns("id", "name", "created_at")
		b.From("devices")
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

		result.Items = append(result.Items, &x)
		return nil
	})
	if err != nil {
		return nil, err
	}
	return &result, nil
}

type GetParam struct {
}

type Device struct {
	ID         uuid.UUID  `json:"id"`
	Name       string     `json:"name"`
	PairUserID uuid.UUID  `json:"pairUserId"`
	PairAt     time.Time  `json:"pairAt"`
	Properties Properties `json:"properties"`
	CreatedAt  time.Time  `json:"createdAt"`
	Token      string     `json:"token"`
}

func Get(ctx context.Context) (*Device, error) {
	userID := auth.GetAccountID(ctx)
	var d Device
	err := pgctx.QueryRow(ctx, `
		select id, token, name, pair_user_id, pair_at, properties, created_at 
		from devices 
		where pair_user_id = $1`,
		userID,
	).Scan(
		&d.ID,
		&d.Token,
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
	ID uuid.UUID `json:"id"`
}

func (p PairParam) Valid() error {
	v := validator.New()
	v.Must(p.ID != uuid.Nil, "id is required")
	return v.Error()
}

func Pair(ctx context.Context, p *PairParam) (err error) {
	userID := auth.GetAccountID(ctx)
	if err := p.Valid(); err != nil {
		return err
	}

	var b bool

	err = pgctx.QueryRow(ctx, `select exists(
	select from devices where id = $1 and pair_user_id is not null)`,
		p.ID,
	).Scan(&b)
	if err != nil {
		return err
	}
	if b {
		return arpc.NewErrorCode("DEVICE_ALREADY_PAIR", "device is already paired")
	}

	err = pgctx.RunInTxOptions(ctx, &pgsql.TxOptions{
		TxOptions: sql.TxOptions{
			Isolation: sql.LevelReadUncommitted,
		},
	}, func(ctx context.Context) error {
		result, err := pgctx.Exec(ctx, `
		update devices 
			set pair_user_id = $2, pair_at = now()
			where id = $1 and pair_user_id is null`,
			p.ID,
			userID,
		)
		if err != nil {
			return err
		}
		rows, err := result.RowsAffected()
		if err != nil {
			return err
		}
		if rows != 1 {
			return ErrNotFound
		}
		return nil
	})
	return
}

type UnPairParam struct {
	ID uuid.UUID `json:"id"`
}

func (p UnPairParam) Valid() error {
	v := validator.New()
	v.Must(p.ID != uuid.Nil, "id is required")
	return v.Error()
}

func UnPair(ctx context.Context, p *UnPairParam) error {
	userID := auth.GetAccountID(ctx)
	if err := p.Valid(); err != nil {
		return err
	}

	err := pgctx.RunInTxOptions(ctx, &pgsql.TxOptions{
		TxOptions: sql.TxOptions{
			//Isolation: sql.LevelReadUncommitted,
		},
	}, func(ctx context.Context) error {
		result, err := pgctx.Exec(ctx, `
			update devices
				set pair_user_id = null, pair_at = null
			where id = $1 and pair_user_id = $2`,
			p.ID,
			userID,
		)
		if err != nil {
			return err
		}
		rows, err := result.RowsAffected()
		if err != nil {
			return err
		}
		if rows != 1 {
			return ErrNotFound
		}
		return nil
	})
	if err != nil {
		return err
	}
	return nil
}

type SetModeParam struct {
	Mode Mode `json:"mode"`
}

func SetMode(ctx context.Context, p *SetModeParam) error {
	userID := auth.GetAccountID(ctx)

	var (
		deviceID   uuid.UUID
		properties Properties
	)

	err := pgctx.QueryRow(ctx, `
			select id, properties from devices where pair_user_id = $1`,
		userID,
	).Scan(
		&deviceID,
		pgsql.JSON(&properties),
	)
	if errors.Is(err, sql.ErrNoRows) {
		return ErrDeviceNotPair
	}
	if err != nil {
		return err
	}
	//

	properties.Mode = p.Mode

	// update value
	_, err = pgctx.Exec(ctx, `update devices set properties = $1 where id = $2`,
		pgsql.JSON(&properties),
		deviceID,
	)
	if err != nil {
		return err
	}
	return nil
}

type UpdateScheduleParam struct {
	Schedule schedule.Schedule `json:"schedule"`
}

func UpdateSchedule(ctx context.Context, p *UpdateScheduleParam) error {
	userID := auth.GetAccountID(ctx)

	var (
		deviceID   uuid.UUID
		properties Properties
	)

	err := pgctx.QueryRow(ctx, `
			select id, properties from devices where pair_user_id = $1`,
		userID,
	).Scan(
		&deviceID,
		pgsql.JSON(&properties),
	)
	if errors.Is(err, sql.ErrNoRows) {
		return ErrDeviceNotPair
	}
	if err != nil {
		return err
	}
	//

	properties.Schedule = p.Schedule

	// update value
	_, err = pgctx.Exec(ctx, `update devices set properties = $1 where id = $2`,
		pgsql.JSON(&properties),
		deviceID,
	)
	if err != nil {
		return err
	}
	return nil
}
