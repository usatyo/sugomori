package util

import (
	"os"

	"github.com/joho/godotenv"
)

func LoadEnv() {
	if os.Getenv("GO_ENV") != "production" {
		// 開発環境での環境変数の読み込み
		err := godotenv.Load(".env.dev")
		if err != nil {
			panic(err)
		}
	}
}
