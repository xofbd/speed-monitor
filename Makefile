SHELL := /bin/bash
TZ ?= UTC

docker_image := speed-monitor

all: run

data/snapshots:
	mkdir -p $@

.PHONY: image | data/snapshots
image:
	docker build \
		-t $(docker_image) \
		--build-arg USER_ID=$$(id -u) \
		--build-arg GROUP_ID=$$(id -g) \
		.

.PHONY: run
run: image | data/snapshots
	docker run \
		--rm \
		-v $(PWD)/data/snapshots:/data/snapshots \
		-e TZ=$(TZ) \
		$(docker_image)

.PHONY: daily
daily: image
	docker run \
		--rm \
		-v $(PWD)/data:/data \
		$(docker_image) \
		process-results
