package main

import (
	"context"
	"database/sql"
	"log"
	"net"
	"time"

	"github.com/acoshift/arpc/v2"
	"github.com/acoshift/configfile"
	"github.com/acoshift/pgsql/pgctx"
	"github.com/moonrhythm/httpmux"
	"github.com/moonrhythm/parapet"
	"golang.org/x/exp/slog"

	"github.com/xkamail/tidaltech/api"
	"github.com/xkamail/tidaltech/pkg/xapi"
)

var r = configfile.NewEnvReader()

func main() {

	if err := run(); err != nil {
		log.Fatal(err)
	}
}

func run() error {
	s := parapet.NewBackend()
	host := r.StringDefault("host", "")
	port := r.StringDefault("port", "8080")

	dbURL := r.String("db_url")

	db, err := sql.Open("postgres", dbURL)
	if err != nil {
		return err
	}
	defer db.Close()

	db.SetMaxIdleConns(r.IntDefault("db_max_idle_conns", 10))
	db.SetMaxOpenConns(r.IntDefault("db_max_open_conns", 10))
	db.SetConnMaxLifetime(r.DurationDefault("db_conn_max_lifetime", 10*time.Minute))

	{
		ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()
		if err := db.PingContext(ctx); err != nil {
			return err
		}
	}

	mux := httpmux.New()

	// setup arpc
	am := arpc.New()
	am.WrapError = xapi.WrapError

	// register api
	api.Mount(mux, am)

	s.Handler = mux

	s.Use(parapet.MiddlewareFunc(pgctx.Middleware(db)))

	s.Addr = net.JoinHostPort(host, port)
	slog.Info("starting server", "addr", s.Addr)

	return s.ListenAndServe()
}
