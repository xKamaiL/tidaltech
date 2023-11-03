package api

import (
	"context"

	"github.com/acoshift/arpc/v2"
	"github.com/moonrhythm/httpmux"

	"github.com/xkamail/tidaltech/api/auth"
	"github.com/xkamail/tidaltech/api/device"
	"github.com/xkamail/tidaltech/api/preset"
)

func Mount(m *httpmux.Mux, am *arpc.Manager) {

	m.Handle("/health.check", am.Handler(func(ctx context.Context) string {
		return "OK"
	}))

	m.Handle("/auth.SignIn", am.Handler(auth.SignIn))
	m.Handle("/auth.SignUp", am.Handler(auth.SignUp))

	m = m.Group("", am.Middleware(authMiddleware))
	// auth
	{
		m.Handle("/auth.SignOut", am.Handler(auth.SignOut))
		m.Handle("/auth.Me", am.Handler(auth.Me))
	}

	// devices
	{
		m.Handle("/devices.List", am.Handler(device.List))
		m.Handle("/devices.Get", am.Handler(device.Get))
		m.Handle("/devices.Pair", am.Handler(device.Pair))
		m.Handle("/devices.UnPair", am.Handler(device.UnPair))
		m.Handle("/devices.setMode", am.Handler(device.SetMode))
		m.Handle("/devices.UpdateTimePoint", am.Handler(device.UpdateSchedule))
	}
	// presets
	{
		m.Handle("/presets.ListPublic", am.Handler(preset.ListPublic))
		m.Handle("/presets.List", am.Handler(preset.List))
		m.Handle("/presets.Create", am.Handler(preset.Create))
		m.Handle("/presets.Update", am.Handler(preset.Update))
		m.Handle("/presets.Delete", am.Handler(preset.Delete))
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
