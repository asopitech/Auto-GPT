.DEFAULT_GOAL := help
.PHONY: help
help: ## <Default> Display this help 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: py-setup
py-setup:	## Python環境構築
	pip install -r requirements.txt

.PHONY: redis
redis: 			## Redis Server 起動
	sudo docker run -d --name redis-stack-server -p 6379:6379 redis/redis-stack-server:latest

.PHONY: first-run
first-run: redis	## 初回起動時のみ実行(Redis, Python)
	python scripts/main.py

.PHONY: run
run:		## 継続モードで起動
	python scripts/main.py --continuous
