SHELL := /usr/bin/env bash
DOCKER_OK := $(shell type -P docker)
TRIVY_OK := $(shell type -P trivy)

help: ## The help text you're reading
	@grep --no-filename -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help

build: ## Build the Docker image
	./bin/build.sh
.PHONY: build

check: ## Check build requirements
    ifeq ('$(DOCKER_OK)','')
	    $(error 'docker' not found!)
    else
	    @echo Found Docker.
    endif
    ifeq ('$(TRIVY_OK)','')
	    $(error package 'trivy' not found!)
    else
	    @echo Found Trivy.
    endif
.PHONY: check
