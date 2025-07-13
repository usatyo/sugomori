# makeを打った時のコマンド
.DEFAULT_GOAL := help

.PHONY: dev
dev: ## ios シミュレータでデバッグを開始
	@flutter run --dart-define-from-file=dart_defines/dev.env

.PHONY: prod-dev
prod-dev: ## ios シミュレータでデバッグを開始（バックエンドは本番環境）
	@flutter run --dart-define-from-file=dart_defines/.env

.PHONY: gen
gen: ## arb ファイルから localization 関連ファイルを自動生成
	@flutter gen-l10n

.PHONY: help
help: ## ヘルプ
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
