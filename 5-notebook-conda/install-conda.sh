#!/bin/bash

# Download Miniconda installer (Linux 64-bit)
echo "Downloading Miniconda..."
curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o Miniconda3.sh

# Auto-install (silent mode, accept license, default location)
echo "Installing Miniconda..."
bash Miniconda3.sh -b -p "$HOME/miniconda3"

# Add Conda to PATH (if not already added)
if ! grep -q 'miniconda3/bin' "$HOME/.bashrc"; then
    echo "Adding Conda to PATH..."
    echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> "$HOME/.bashrc"
fi

# Initialize Conda for the current shell
source "$HOME/miniconda3/bin/activate"
eval "$(conda shell.bash hook)"

# Clean up installer
rm Miniconda3.sh

# Verify installation
echo "Miniconda installed successfully!"
conda --version

# Create environment
echo "Creating conda environment..."
conda create -n myenv python=3.13 -y

# Install packages
echo "Installing packages..."
conda run -n myenv pip install jupyter notebook numpy ipykernel

# Set up Jupyter kernel
echo "Setting up Jupyter kernel..."
conda run -n myenv python -m ipykernel install --user --name=my_kernel --display-name="My Kernel"

# Start Jupyter Notebook
echo "Starting Jupyter Notebook..."
echo "open brower <ip-address>:8888"
conda run -n myenv jupyter notebook \
    --ip=0.0.0.0 \
    --port=8888 \
    --no-browser \
    --allow-root \
    --NotebookApp.token='password' \
    --NotebookApp.password=''

echo "Setup complete!"
