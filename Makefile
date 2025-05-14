.PHONY: build run test clean docker-build docker-push tilt-up tilt-down

# Variables
APP_NAME := go-app
REGISTRY := harbor.mbizmarket.my.id:14567
IMAGE_NAME := $(REGISTRY)/tilt/$(APP_NAME)
VERSION ?= latest

# Go commands
build:
	@echo "Building $(APP_NAME)..."
	cd apps/go-app && go build -o bin/server ./cmd/server

run: build
	@echo "Running $(APP_NAME)..."
	cd apps/go-app && ./bin/server

test:
	@echo "Running tests..."
	cd apps/go-app && go test -v ./...

clean:
	@echo "Cleaning..."
	rm -rf apps/go-app/bin
	rm -rf apps/go-app/tmp

# Docker commands
docker-build:
	@echo "Building Docker image..."
	docker build -t $(IMAGE_NAME):$(VERSION) -f deploy/docker/Dockerfile apps/go-app

docker-push: docker-build
	@echo "Pushing Docker image..."
	docker push $(IMAGE_NAME):$(VERSION)
	docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):latest
	docker push $(IMAGE_NAME):latest

# Tilt commands
tilt-up:
	@echo "Starting Tilt..."
	tilt up

tilt-down:
	@echo "Stopping Tilt..."
	tilt down

# Development tools
install-tools:
	@echo "Installing development tools..."
	go install github.com/cosmtrek/air@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

lint:
	@echo "Running linters..."
	cd apps/go-app && golangci-lint run

# Help
help:
	@echo "Available targets:"
	@echo "  build         - Build the application"
	@echo "  run          - Run the application"
	@echo "  test         - Run tests"
	@echo "  clean        - Clean build artifacts"
	@echo "  docker-build - Build Docker image"
	@echo "  docker-push  - Push Docker image to registry"
	@echo "  tilt-up      - Start Tilt development environment"
	@echo "  tilt-down    - Stop Tilt development environment"
	@echo "  install-tools - Install development tools"
	@echo "  lint         - Run linters" 