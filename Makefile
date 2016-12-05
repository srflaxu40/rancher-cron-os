#Most vars can be ovewritten with ENV vars (like Jenkins)
BUILD_DATE ?= $(strip $(shell date -u +"%Y-%m-%dT%H:%M:%SZ"))
VENDOR ?= demandbase
PROJECT_NAME ?= rancher-cron-os
DOCKER_IMAGE ?= $(VENDOR)/$(PROJECT_NAME)
DATABASE_URL ?=
SHA ?=
ENVIRONMENT ?= staging
REGION ?= us-west-1
GIT_COMMIT = $(strip $(shell git rev-parse --short HEAD))
GIT_URL ?= $(strip $(shell git config --get remote.origin.url))
BRANCH_NAME ?= develop

# Find out if the working directory is clean
GIT_NOT_CLEAN_CHECK = $(shell git status --porcelain)

default: build

build: docker_build output

push: docker_push

# Generate SHA for downstream tagging with Docker:
GIT_COMMIT=$(shell git rev-parse HEAD)
DOCKER_GIT_TAG=$(shell echo "${GIT_COMMIT}" | cut -c1-7)

#Set DOCKER_TAG
DOCKER_TAG = $(DOCKER_GIT_TAG)-$(BRANCH_NAME)-$(ENVIRONMENT)

docker_build:
	# Build Docker image
	docker build \
	--no-cache \
	-t $(DOCKER_IMAGE):$(DOCKER_TAG) .

run:
	docker run -d -p 5601:5601 -it $(DOCKER_IMAGE):$(DOCKER_TAG)

docker_push:
	# Push to DockerHub
	docker push $(DOCKER_IMAGE):$(DOCKER_GIT_TAG)-$(BRANCH_NAME)-$(ENVIRONMENT)

output:
	@echo Docker Image: $(DOCKER_IMAGE):$(DOCKER_TAG)

