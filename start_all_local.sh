#!/bin/bash

echo "Starting local services..."

echo "Starting Database (bd_post)..."
(cd db && docker-compose -f docker-compose.local.yml up -d)

echo "Starting Front-End..."
(cd Front-End && docker-compose -f docker-compose.local.yml up -d)

echo "Starting servicio-auth..."
(cd servicio-auth && docker-compose -f docker-compose.local.yml up -d)

echo "Starting servicio-pagos..."
(cd servicio-pagos && docker-compose -f docker-compose.local.yml up -d)

echo "Starting servicio-test..."
(cd servicio-test && docker-compose -f docker-compose.local.yml up -d)

echo "Starting servicio-universidades..."
(cd servicio-universidades && docker-compose -f docker-compose.local.yml up -d)

echo "Starting api-gateway..."
(cd api-gateway && docker-compose -f docker-compose.local.yml up -d)

echo "All local services initiated." 