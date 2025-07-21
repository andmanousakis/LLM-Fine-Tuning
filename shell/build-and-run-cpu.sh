# File: shell/build-and-run-cpu.sh

#!/bin/bash
set -e

echo "Building and running CPU version with Docker Compose..."
docker compose -f docker/docker-compose.cpu.yml up --build