package main

import (
	"log"
	"net"

	"github.com/moonrhythm/parapet"
	"golang.org/x/exp/slog"
)

func main() {

	if err := run(); err != nil {
		log.Fatal(err)
	}
}

func run() error {
	s := parapet.NewBackend()

	s.Addr = net.JoinHostPort("", "8080")
	slog.Info("starting server", "addr", s.Addr)
	return s.ListenAndServe()
}
