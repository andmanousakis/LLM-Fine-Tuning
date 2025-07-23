# File: shell/clean-all.sh

#!/bin/bash

echo "Stopping all running containers..."
docker stop $(docker ps -q)

echo "Pruning stopped containers, unused images, networks, and build cache..."
docker system prune -af --volumes

echo "Docker cleanup complete."