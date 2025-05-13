package db

import (
	"context"
	"os"

	"github.com/neo4j/neo4j-go-driver/v5/neo4j"
)

var Driver neo4j.DriverWithContext
var Ctx context.Context

func Initialize() {
    Ctx = context.Background()
    dbUri := os.Getenv("NEO4J_URI")
    dbUser := os.Getenv("NEO4J_USERNAME")
    dbPassword := os.Getenv("NEO4J_PASSWORD")
    driver, err := neo4j.NewDriverWithContext(
        dbUri,
        neo4j.BasicAuth(dbUser, dbPassword, ""))
		if err != nil {
            panic(err)
		}
    Driver = driver
}