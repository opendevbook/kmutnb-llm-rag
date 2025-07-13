#!/bin/bash

# Docker Installation Script for Ubuntu 24.04

# Exit immediately if any command fails
set -e

# Update package index
echo "Updating package index..."
sudo apt-get update -y

# Install prerequisite packages
echo "Installing prerequisites..."
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
echo "Adding Docker's GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repository
echo "Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again
echo "Updating package index with Docker repository..."
sudo apt-get update -y 

# Install Docker Engine
echo "Installing Docker Engine..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Enable and Start Docker service"
sudo systemctl enable --now docker
# Verify Docker installation

# Add current user to docker group to run docker without sudo
echo "Adding current user to docker group..."
sudo usermod -aG docker $USER
newgrp docker
```

### สร้าง postgresql + vector Database
```

echo ""
echo "Docker installation completed successfully!"
echo "You may need to log out and back in for group changes to take effect."
echo "After that, you can run docker commands without sudo."