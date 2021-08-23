SHELL := /bin/bash
TZ ?= UTC

docker_image := speed-test

all: docker-run

.PHONY: docker-build
docker-build:
	docker build \
		-t $(docker_image) \
		--build-arg USER_ID=$$(id -u) \
		--build-arg GROUP_ID=$$(id -g) \
		.

.PHONY: docker-run
docker-run: docker-build
	docker run \
		--rm \
		-v $(PWD)/data/snapshots:/data/snapshots \
		-e TZ=$(TZ) \
		$(docker_image)
