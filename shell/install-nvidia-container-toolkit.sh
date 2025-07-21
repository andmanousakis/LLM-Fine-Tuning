# File: shell/install-nvidia-toolkit.sh

#!/bin/bash
set -e  # Exit immediately if any command fails

# Detect OS distribution.
distribution="ubuntu22.04"

# Add NVIDIA GPG key.
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
    gpg --dearmor | sudo tee /etc/apt/keyrings/nvidia-container-toolkit.gpg > /dev/null

# Add the repository with signed-by config.
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
    sed 's#deb https://#deb [signed-by=/etc/apt/keyrings/nvidia-container-toolkit.gpg] https://#' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null

# Install the toolkit.
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Restart Docker to apply changes.
sudo systemctl restart docker

echo "✅ NVIDIA Container Toolkit installed and Docker restarted."
