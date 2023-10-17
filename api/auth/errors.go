package auth

import "github.com/acoshift/arpc/v2"

var (
	ErrPasswordMismatch = arpc.NewErrorCode("AUTH_PASSWORD_MISMATCH", "auth: username or password incorrect")
	ErrProfileNotFound  = arpc.NewErrorCode("AUTH_PROFILE_NOT_FOUND", "auth: profile not found")
)
