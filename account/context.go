package account

import "context"

type ctxKey struct {
}

func NewContext(ctx context.Context, p *User) context.Context {
	return context.WithValue(ctx, ctxKey{}, p)
}

func FromContext(ctx context.Context) (*User, error) {
	p, ok := ctx.Value(ctxKey{}).(*User)
	if !ok {
		return nil, ErrNoUserInContext
	}
	return p, nil
}
