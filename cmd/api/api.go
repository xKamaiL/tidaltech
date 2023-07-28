package main

import (
	"log"

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

	slog.Info("starting server")
	return s.ListenAndServe()
}
