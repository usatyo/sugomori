# makeを打った時のコマンド
.DEFAULT_GOAL := help

.PHONY: dev
dev: ## 開発環境を起動
	@go run main.go

.PHONY: test
test: ## テストを実行
	@go test ./...

.PHONY: format
format: ## backend ディレクトリの Go ファイルをすべてフォーマット
	@go fmt ./...

.PHONY: build
build: ## イメージを構築
	@docker compose build

.PHONY: start
start: ## コンテナを構築 & コンテナに入る
	@docker compose up -d
	@docker compose exec backend /bin/bash -login

.PHONY: down
down: ## コンテナ停止
	@docker compose down

.PHONY: deploy
deploy: ## Google Cloud にデプロイ
	@gcloud builds submit --region=asia-east1 --substitutions=_AR_REPO_NAME="sugomori-backend"

.PHONY: token
token: ## Google Cloud のトークンを取得
	@gcloud auth print-identity-token

.PHONY: help
help: ## ヘルプ
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
