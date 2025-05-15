
#!/bin/bash
# reset_front.sh
# This script stops the Front-End (angular-app) and rebuilds the image.

set -e # Exit immediately if a command exits with a non-zero status.

echo "INFO: Stopping Front-End (angular-app)..."
docker-compose -f Front-End/docker-compose.local.yml down

echo "INFO: Building Front-End (angular-app)..."
docker-compose -f Front-End/docker-compose.local.yml build --no-cache angular-app

echo "INFO: Starting Front-End (angular-app)..."
docker-compose -f Front-End/docker-compose.local.yml up -d angular-app

echo "INFO: Front-End (angular-app) started successfully"