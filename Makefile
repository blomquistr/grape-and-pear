BUILDER := $(shell if command -v podman >/dev/null 2>&1; then echo "podman"; elif command -v docker >/dev/null 2>&1; then echo "docker"; else echo "none"; fi)
IMAGE_TAG := $(shell git describe --tags --dirty --always)
IMAGE_REPO := "docker.io/lunarfish"

.PHONY: build tag push all

build:
	@echo "Building grape-and-pear image with tag $(IMAGE_TAG)"
	@$(BUILDER) image build \
	--platform linux/amd64 \
	-f Containerfile.grape-and-pear \
	-t $(IMAGE_REPO)/grape-and-pear:$(IMAGE_TAG) \
	.

tag:
	@echo "Updating latest tag for grape-and-pear image to $(IMAGE_TAG)"
	@$(BUILDER) image tag $(IMAGE_REPO)/grape-and-pear:$(IMAGE_TAG) $(IMAGE_REPO)/grape-and-pear:latest

push:
	@echo "Pushing grape-and-pear image to $(IMAGE_REPO)"
	@$(BUILDER) image push $(IMAGE_REPO)/grape-and-pear:$(IMAGE_TAG)
	@$(BUILDER) image push $(IMAGE_REPO)/grape-and-pear:latest

all: build tag push
