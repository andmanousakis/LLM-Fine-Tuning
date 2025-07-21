# File: shell/build-and-run-gpu.sh

#!/bin/bash
set -e

echo "Building and running GPU version with Docker Compose..."
docker compose -f docker/docker-compose.gpu.yml up --build
