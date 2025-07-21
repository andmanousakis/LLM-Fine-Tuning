# File: shell/build-and-run.sh

#!/bin/bash
set -e

echo "Building and running..."
docker compose -f docker/docker-compose.yml up --build
