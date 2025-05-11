#!/bin/bash
# reset_and_rebuild_all_local.sh
# This script stops all services, removes the database volume, rebuilds images, and starts all services.

set -e # Exit immediately if a command exits with a non-zero status.

echo "INFO: Stopping all local services..."
if [ -f ./stop_all_local.sh ]; then
    ./stop_all_local.sh
else
    echo "WARNING: ./stop_all_local.sh not found. You may need to stop services manually."
fi

echo "INFO: Ensuring database container (bd_post) is down before removing volume..."
docker-compose -f db/docker-compose.local.yml down

echo "INFO: Removing database volume (db_pgdata)..."
docker volume rm db_pgdata || echo "INFO: db_pgdata volume not found or already removed."

echo "INFO: Building Front-End (angular-app)..."
docker-compose -f Front-End/docker-compose.local.yml build --no-cache angular-app

echo "INFO: Building servicio-auth (servicio-autenticacion)..."
docker-compose -f servicio-auth/docker-compose.local.yml build --no-cache servicio-autenticacion

echo "INFO: Building servicio-pagos (servicio-pagos)..."
docker-compose -f servicio-pagos/docker-compose.local.yml build --no-cache servicio-pagos

echo "INFO: Building servicio-test (servicio-test)..."
docker-compose -f servicio-test/docker-compose.local.yml build --no-cache servicio-test

echo "INFO: Building servicio-universidades (servicio-universidades)..."
docker-compose -f servicio-universidades/docker-compose.local.yml build --no-cache servicio-universidades

echo "INFO: All builds complete."

echo "INFO: Starting all local services..."
if [ -f ./start_all_local.sh ]; then
    ./start_all_local.sh
else
    echo "WARNING: ./start_all_local.sh not found. You will need to start services manually."
fi

echo "INFO: All services should be starting up. Please check their status." 