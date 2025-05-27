package util

import (
	"os"

	"github.com/joho/godotenv"
)

func LoadEnvVar(path string) {
	if os.Getenv("GO_ENV") != "production" {
		// 開発環境での環境変数の読み込み
		err := godotenv.Load(path)
		if err != nil {
			panic(err)
		}
	}
}
