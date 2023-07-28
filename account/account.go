package account

import (
	"errors"
	"time"

	"github.com/google/uuid"
)

var (
	ErrNoUserInContext = errors.New("no user in context")
)

type User struct {
	ID uuid.UUID `json:"id"`
	// Username is the username of the user
	Username string `json:"username"`
	// Password is the password of the user
	Password string `json:"-"`
	// Email is the email of the user
	Email     string    `json:"email"`
	AvatarURL *string   `json:"avatarUrl"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}
