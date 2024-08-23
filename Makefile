# Default goal
.DEFAULT_GOAL := help

# Phony targets
.PHONY: run lint format test publish shell clean help check sast debug-test simulate

# Variables
COMPOSE_RUNNER := docker compose
APP_NAME := app
USE_DOCKER_CACHE ?= true

# ANSI color codes
BLUE := \033[34m
RESET := \033[0m

export APP_NAME

# Helper functions
define run
	@echo "[INFO] Building with cache: $(USE_DOCKER_CACHE)"
	$(COMPOSE_RUNNER) build $(if $(filter false,$(USE_DOCKER_CACHE)),--no-cache,) $1
	$(COMPOSE_RUNNER) run --rm $1
endef

define run_step
	@echo "[INFO] Running $1..."
	@$(MAKE) $1
endef

# Main targets
run: ## Run the application
	$(call run,app)

lint: ## Run the linter
	$(call run,$@)

format: ## Run the formatter
	$(call run,$@)

test: ## Run the tests
	$(call run,$@)

publish: ## Publish the application
	$(call run,$@)

sast: ## Run SAST (Static Application Security Testing)
	$(call run,$@)

shell: ## Open a shell in a specific service (prompts for service name)
	@services=$$($(COMPOSE_RUNNER) config --services | sort | tr '\n' ' '); \
	formatted_services=$$(echo $$services | sed 's/ /", "/g' | sed 's/^/["/' | sed 's/$$/"]/'); \
	echo "Available services: $$formatted_services"; \
	read -p "Enter service name: " service; \
	echo "Opening shell in $$service"; \
	$(COMPOSE_RUNNER) run --rm -it --entrypoint /bin/sh $$service

clean: ## Remove all Docker resources related to this project
	$(COMPOSE_RUNNER) down --rmi all --volumes --remove-orphans

help: ## Display this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*?## "}; \
		/^[a-zA-Z_-]+:.*?## / {printf "  $(BLUE)%-15s$(RESET) %s\n", $$1, $$2}' \
		$(MAKEFILE_LIST) | sort

simulate: format lint test sast ## Simulate a pipeline run

# Debugging target
debug-test: ## Run tests with debugging enabled
	@echo "[INFO] Running tests with debugging enabled"
	$(COMPOSE_RUNNER) run --rm -e DEBUG=1 test