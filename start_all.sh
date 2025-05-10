#!/bin/bash

# Script to start all Docker Compose services in the specified directories

BASE_DIR=$(dirname "$0")
NETWORK_NAME="app-network"

# Check if the network exists, create if it doesn't
if ! docker network inspect $NETWORK_NAME >/dev/null 2>&1; then
    echo "Creating Docker network: $NETWORK_NAME..."
    docker network create $NETWORK_NAME || {
        echo "Failed to create network $NETWORK_NAME. Exiting."
        exit 1
    }
    echo "Network $NETWORK_NAME created."
else
    echo "Network $NETWORK_NAME already exists."
fi

DIRECTORIES=(
    "db"
    "servicio-auth"
    "servicio-test"
    "servicio-pagos"
    "servicio-universidades"
    "api-gateway"
    "Front-End"
)

for dir in "${DIRECTORIES[@]}"; do
    echo "Starting services in $dir..."
    if [ "$dir" == "Front-End" ]; then
        echo "Performing full down, no-cache build, and up for Front-End..."
        (cd "$BASE_DIR/$dir" && docker-compose -f docker-compose.local.yml down && docker-compose -f docker-compose.local.yml build --no-cache && docker-compose -f docker-compose.local.yml up -d) || echo "Failed to start services in $dir using local config with no-cache, continuing..."
    elif [ "$dir" == "servicio-test" ] || [ "$dir" == "servicio-auth" ] || [ "$dir" == "servicio-pagos" ] || [ "$dir" == "servicio-universidades" ]; then
        (cd "$BASE_DIR/$dir" && docker-compose -f docker-compose.local.yml up -d --build) || echo "Failed to start services in $dir using local config, continuing..."
    else
    (cd "$BASE_DIR/$dir" && docker-compose up -d --build) || echo "Failed to start services in $dir, continuing..."
    fi
    echo "--------------------"
done

echo "All specified services started (or attempted to start)." 