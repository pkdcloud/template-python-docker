.PHONY: lint format test publish shell clean help check sast

COMPOSE_RUNNER := docker compose
APP_NAME := app
USE_DOCKER_CACHE ?= true
export APP_NAME

.DEFAULT_GOAL := help

define run
	@echo "[INFO] Building with cache: $(USE_DOCKER_CACHE)"
    $(COMPOSE_RUNNER) build $(if $(filter false,$(USE_DOCKER_CACHE)),--no-cache,) $1
    $(COMPOSE_RUNNER) run --rm $1
endef

lint format test publish sast:
	$(call run,$@)

shell:
	@services=$$($(COMPOSE_RUNNER) config --services | sort | tr '\n' ' '); \
	formatted_services=$$(echo $$services | sed 's/ /", "/g' | sed 's/^/["/' | sed 's/$$/"]/'); \
	echo "Available services: $$formatted_services"; \
	read -p "Enter service name: " service; \
	echo "Opening shell in $$service"; \
	$(COMPOSE_RUNNER) run --rm -it --entrypoint /bin/sh $$service


check: ## Run format, lint, and test in sequence
	@echo "Running format..."
	@$(MAKE) format
	@echo "Running lint..."
	@$(MAKE) lint
	@echo "Running tests..."
	@$(MAKE) test

help:
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  make %-15s %s\n", $$1, $$2}'

clean:
	$(COMPOSE_RUNNER) down --rmi all --volumes --remove-orphans

lint: ## Run linter
format: ## Run formatter
test: ## Run tests
publish: ## Publish the application
sast: ## Run SAST (Bandit) analysis
shell: ## Open a shell in a specific service (prompts for service name)
clean: ## Remove all Docker resources related to this project
simulate: format lint test
