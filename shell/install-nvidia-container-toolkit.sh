# File: shell/install-nvidia-toolkit.sh

#!/bin/bash
set -e  # Exit if any command fails

# Add NVIDIA package repositories.
distribution=$(. /etc/os-release; echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Add NVIDIA GPG key.
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | \
  sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

# Update apt and install the toolkit.
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Restart Docker daemon to apply changes.
sudo systemctl restart docker

echo "✅ NVIDIA Container Toolkit installed and Docker restarted."
