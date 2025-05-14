# Go Application Monorepo

This is a monorepo containing a Go application with Kubernetes deployment configuration.

## Project Structure

```
.
├── apps/
│   └── go-app/              # Main application
│       ├── cmd/
│       │   └── server/      # Application entry point
│       ├── internal/        # Private application code
│       ├── pkg/            # Public library code
│       └── api/            # API definitions
├── deploy/
│   ├── kubernetes/         # K8s manifests
│   └── docker/            # Docker-related files
├── tools/                  # Development tools
└── docs/                  # Documentation
```

## Prerequisites

- Go 1.21 or later
- Docker
- Kubernetes cluster (k3d)
- Tilt
- Harbor registry access

## Development

### Setup

1. Install development tools:
   ```bash
   make install-tools
   ```

2. Start the development environment:
   ```bash
   make tilt-up
   ```

### Available Commands

- `make build` - Build the application
- `make run` - Run the application locally
- `make test` - Run tests
- `make docker-build` - Build Docker image
- `make docker-push` - Push Docker image to registry
- `make tilt-up` - Start Tilt development environment
- `make tilt-down` - Stop Tilt development environment
- `make lint` - Run linters

## Deployment

The application is configured to deploy to Kubernetes using Tilt. The deployment process:

1. Creates a Harbor registry secret
2. Builds the Docker image
3. Deploys to Kubernetes
4. Sets up port forwarding

## Configuration

### Harbor Registry

The application uses Harbor registry for container images. Configuration is in the Tiltfile:

```python
registry = "harbor.mbizmarket.my.id:14567"
image_name = registry + "/tilt/go-app"
```

### Kubernetes

Kubernetes manifests are located in `deploy/kubernetes/`:

- `deployment.yaml` - Main application deployment
- Service configuration
- Resource limits and requests

## Contributing

1. Create a new branch for your feature
2. Make your changes
3. Run tests and linters
4. Submit a pull request

## License

[Your License Here] 