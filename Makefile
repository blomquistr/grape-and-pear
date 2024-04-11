# import configuration
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# import deployment configuraiton
dpl ?= deployment.env
include $(dpl)
export $(shell sed 's/=.*//' $(dpl))

VERSION=$(shell git describe --tags --always --dirty)

# HELP
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# Container builds
build:
	
	@echo "Building container"
	@podman image build -t $(CONTAINER_NAME):$(VERSION) .
