package schema

import (
	"context"
	"embed"

	"github.com/acoshift/pgsql/pgctx"
)

//go:embed *.sql
var files embed.FS

func Migrate(ctx context.Context) error {
	entries, err := files.ReadDir(".")
	if err != nil {
		return err
	}
	for _, entry := range entries {
		if entry.IsDir() {
			continue
		}
		// read file
		data, err := files.ReadFile(entry.Name())
		if err != nil {
			return err
		}
		// execute file
		_, err = pgctx.Exec(ctx, string(data))
		if err != nil {
			return err
		}
	}
	return nil

}
