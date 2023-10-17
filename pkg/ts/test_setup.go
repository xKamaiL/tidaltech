package ts

import (
	"context"
	"crypto/rand"
	"database/sql"
	"fmt"
	"io"
	"math"
	"math/big"
	"os"

	"github.com/acoshift/pgsql/pgctx"
	"github.com/lib/pq"

	"github.com/xkamail/tidaltech/schema"
)

const masterDBName = "neondb"

type DB struct {
	db       *sql.DB
	masterDB *sql.DB
	dbName   string
}

func New() *DB {
	dbURL := os.Getenv("TEST_DB_URL")
	x := DB{}

	db, err := sql.Open("postgres",
		fmt.Sprintf(dbURL, masterDBName),
	)
	if err != nil {
		panic(err)
	}
	x.masterDB = db

	buf := make([]byte, 100)

	_, err = io.ReadFull(rand.Reader, buf)
	if err != nil {
		panic(fmt.Sprintf("crypto/rand is unavailable: Read() failed with %#v", err))
	}
	n, err := rand.Int(rand.Reader, big.NewInt(math.MaxInt64))
	if err != nil {
		panic(err)
	}

	dbName := fmt.Sprintf("%d", int(n.Int64()))

	// language=TEXT
	_, err = db.Exec("create database " + pq.QuoteIdentifier(dbName) + ";")
	if err != nil {
		panic(err)
	}
	db, err = sql.Open("postgres",
		fmt.Sprintf(dbURL, dbName),
	)
	if err != nil {
		panic(err)
	}
	x.dbName = dbName
	x.db = db

	// setup schema
	if err := schema.Migrate(
		x.Ctx(),
	); err != nil {
		panic(err)
	}

	// setup fixtures
	_, err = db.Exec(`
		insert into users (id, email, password) values ('00000000-0000-0000-0000-000000000001','test@email.com',now())
	`)
	if err != nil {
		panic(err)
	}

	return &x
}

func (d DB) Ctx() context.Context {
	return pgctx.NewContext(context.Background(), d.db)
}

func (d DB) Teardown() {
	d.db.Close()
	d.masterDB.Exec("drop database " + pq.QuoteIdentifier(d.dbName))
	d.masterDB.Close()
}
