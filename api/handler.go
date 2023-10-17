package api

import (
	"context"

	"github.com/acoshift/arpc/v2"
	"github.com/moonrhythm/httpmux"

	"github.com/xkamail/tidaltech/api/auth"
)

func Mount(m *httpmux.Mux, am *arpc.Manager) {

	m.Handle("/health.check", am.Handler(func(ctx context.Context) string {
		return "OK"
	}))

	m.Handle("/auth.SignIn", am.Handler(auth.SignIn))

	m = m.Group("", am.Middleware(authMiddleware))
	{
		m.Handle("/auth.me", nil)
	}
}

var errUnauthorized = arpc.NewErrorCode("UNAUTHORIZED", "unauthorized")

func authMiddleware(r *arpc.MiddlewareContext) error {

	token := r.Request().Header.Get("Authorization")

	if token == "" {
		return errUnauthorized
	}

	// TODO: set token
	r.SetRequestContext(r.Request().Context())
	return nil
}
