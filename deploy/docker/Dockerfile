# Build stage
FROM golang:1.21-alpine AS builder

WORKDIR /build

# Copy go mod and sum files
COPY go.mod ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/server ./cmd/server

# Final stage
FROM golang:1.21-alpine

WORKDIR /app

# Install Air binary directly
RUN apk add --no-cache wget && \
    wget -O /usr/local/bin/air https://github.com/cosmtrek/air/releases/download/v1.49.0/air_1.49.0_linux_amd64 && \
    chmod +x /usr/local/bin/air && \
    apk del wget

# Copy the binary and Air config
COPY --from=builder /app/server .
COPY .air.toml .
COPY go.mod .
COPY cmd ./cmd
COPY internal ./internal
COPY pkg ./pkg
COPY api ./api

# Expose port
EXPOSE 8080

# Use Air for hot reloading
ENTRYPOINT ["air", "-c", ".air.toml"] 