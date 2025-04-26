# makeを打った時のコマンド
.DEFAULT_GOAL := help

.PHONY: start
start: ## ios シミュレータでデバッグを開始
	@flutter run --dart-define-from-file=dart_defines/dev.env

.PHONY: help
help: ## ヘルプ
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
