# Enable debug mode
debug = True

# Use Harbor registry
registry = "harbor.mbizmarket.my.id:14567"
image_name = registry + "/tilt/go-app"

# Create Harbor secret
local_resource(
    'harbor-secret',
    cmd='kubectl create secret docker-registry harbor-secret --docker-server=harbor.mbizmarket.my.id:14567 --docker-username=mbiz-tech --docker-password=Mbiz123! --docker-email=mbiz-tech@mbizmarket.my.id --dry-run=client -o yaml | kubectl apply -f -',
    deps=[],
    ignore=['.git'],
    auto_init=True
)

# Load the Kubernetes deployment
k8s_yaml('deploy/kubernetes/deployment.yaml')

# Build the Docker image
docker_build(
    image_name,
    'apps/go-app',
    dockerfile='deploy/docker/Dockerfile',
    live_update=[
        sync('apps/go-app', '/app'),
        run('cd /app && go mod download'),
        run('cd /app && go build -o /app/server ./cmd/server')
    ]
)

# Port forward the service
k8s_resource(
    'go-app',
    port_forwards='8081:8080'
) 