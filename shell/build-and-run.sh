# File: shell/build-and-run.sh

#!/bin/bash
set -e

echo "Building and running with Docker Compose..."
docker compose -f docker/docker-compose.yml up --build
