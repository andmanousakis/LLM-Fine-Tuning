# File: shell/clean-gpu.sh

#!/bin/bash
set -e

IMAGE_NAME="llm-api-gpu"
CONTAINER_NAME="llm-api-gpu-container"

echo "Stopping and removing ONLY the $CONTAINER_NAME container (if running)..."
docker rm -f $CONTAINER_NAME 2>/dev/null || true

echo "Removing ONLY the $IMAGE_NAME image (if exists)..."
docker rmi $IMAGE_NAME 2>/dev/null || true

echo "Clean-up complete."
