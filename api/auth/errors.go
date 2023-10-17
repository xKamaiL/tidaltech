package auth

import "github.com/acoshift/arpc/v2"

var (
	ErrProfileNotFound = arpc.NewErrorCode("AUTH_PROFILE_NOT_FOUND", "auth: profile not found")
)
