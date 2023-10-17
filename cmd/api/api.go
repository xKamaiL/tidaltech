package main

import (
	"log"
	"net"

	"github.com/acoshift/arpc/v2"
	"github.com/moonrhythm/httpmux"
	"github.com/moonrhythm/parapet"
	"golang.org/x/exp/slog"

	"github.com/xkamail/tidaltech/api"
	"github.com/xkamail/tidaltech/pkg/xapi"
)

func main() {

	if err := run(); err != nil {
		log.Fatal(err)
	}
}

func run() error {
	s := parapet.NewBackend()

	mux := httpmux.New()

	am := arpc.New()
	am.WrapError = xapi.WrapError

	api.Mount(mux, am)

	s.Handler = mux
	s.Addr = net.JoinHostPort("", "8080")
	slog.Info("starting server", "addr", s.Addr)
	return s.ListenAndServe()
}
