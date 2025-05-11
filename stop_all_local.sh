#!/bin/bash

echo "Stopping local services..."

echo "Stopping api-gateway..."
(cd api-gateway && docker-compose -f docker-compose.local.yml down)

echo "Stopping servicio-universidades..."
(cd servicio-universidades && docker-compose -f docker-compose.local.yml down)

echo "Stopping servicio-test..."
(cd servicio-test && docker-compose -f docker-compose.local.yml down)

echo "Stopping servicio-pagos..."
(cd servicio-pagos && docker-compose -f docker-compose.local.yml down)

echo "Stopping servicio-auth..."
(cd servicio-auth && docker-compose -f docker-compose.local.yml down)

echo "Stopping Front-End..."
(cd Front-End && docker-compose -f docker-compose.local.yml down)

echo "Stopping Database (bd_post)..."
(cd db && docker-compose -f docker-compose.local.yml down)

echo "All local services stopped." 