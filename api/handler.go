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
	// auth
	{
		m.Handle("/auth.SignOut", am.Handler(auth.SignOut))
		m.Handle("/auth.Me", am.Handler(auth.Me))
	}

	// devices
	{
		m.Handle("/devices.List", nil)
		m.Handle("/devices.Pair", nil)
		m.Handle("/devices.UnPair", nil)
	}

	// lighting
	{
		m.Handle("/lighting.Mode", nil)
		m.Handle("/lighting.SetMode", nil)
		m.Handle("/lighting.GetSchedule", nil)
		m.Handle("/lighting.SetSchedule", nil)

	}
}

var errUnauthorized = arpc.NewErrorCode("UNAUTHORIZED", "unauthorized")

func authMiddleware(r *arpc.MiddlewareContext) error {
	ctx := r.Request().Context()

	token := r.Request().Header.Get("Authorization")

	if token == "" {
		return errUnauthorized
	}
	// Bearer token

	if len(token) < 7 || token[:7] != "Bearer " {
		return arpc.NewErrorCode("INVALID_TOKEN_PREFIX", "invalid token prefix")
	}

	token = token[7:]
	userID, err := auth.GetToken(ctx, auth.HashToken(token))
	if err != nil {
		return errUnauthorized
	}

	ctx = auth.NewAccountIDContext(ctx, userID)

	// TODO: set token
	r.SetRequestContext(ctx)
	return nil
}
