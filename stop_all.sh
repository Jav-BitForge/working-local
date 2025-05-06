#!/bin/bash

# Script to stop all Docker Compose services in the specified directories

BASE_DIR=$(dirname "$0")

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
    echo "Stopping services in $dir..."
    # Use local compose file if it's servicio-test, Front-End, servicio-auth, servicio-pagos, or servicio-universidades
    if [ "$dir" == "servicio-test" ] || [ "$dir" == "Front-End" ] || [ "$dir" == "servicio-auth" ] || [ "$dir" == "servicio-pagos" ] || [ "$dir" == "servicio-universidades" ]; then
        (cd "$BASE_DIR/$dir" && docker-compose -f docker-compose.local.yml down) || echo "Failed to stop services in $dir using local config, continuing..."
    else
    (cd "$BASE_DIR/$dir" && docker-compose down) || echo "Failed to stop services in $dir, continuing..."
    fi
    echo "--------------------"
done

echo "All specified services stopped." 