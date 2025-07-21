# File: shell/build-and-run.sh

#!/bin/bash
set -e

if [[ "$1" == "cpu" ]]; then
  echo "Building and running CPU version with Docker Compose..."
  docker compose -f docker/docker-compose.cpu.yml up --build
elif [[ "$1" == "gpu" ]]; then
  echo "Building and running GPU version with Docker Compose..."
  docker compose -f docker/docker-compose.gpu.yml up --build
else
  echo "Usage: $0 [cpu|gpu]"
  exit 1
fi
