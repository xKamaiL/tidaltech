package auth

import (
	"context"

	"github.com/google/uuid"
)

type ctxAccountIDKey struct {
}

func NewAccountIDContext(ctx context.Context, userID uuid.UUID) context.Context {
	return context.WithValue(ctx, ctxAccountIDKey{}, userID)
}

func GetAccountID(ctx context.Context) uuid.UUID {
	return ctx.Value(ctxAccountIDKey{}).(uuid.UUID)
}
