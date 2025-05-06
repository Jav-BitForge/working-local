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
    # Use local compose file if it's servicio-test, Front-End, servicio-auth, servicio-pagos, or servicio-universidades
    if [ "$dir" == "servicio-test" ] || [ "$dir" == "Front-End" ] || [ "$dir" == "servicio-auth" ] || [ "$dir" == "servicio-pagos" ] || [ "$dir" == "servicio-universidades" ]; then
        (cd "$BASE_DIR/$dir" && docker-compose -f docker-compose.local.yml up -d --build) || echo "Failed to start services in $dir using local config, continuing..."
    else
    (cd "$BASE_DIR/$dir" && docker-compose up -d --build) || echo "Failed to start services in $dir, continuing..."
    fi
    echo "--------------------"
done

echo "All specified services started (or attempted to start)." 