#!/bin/bash

# Install Ollama if not already installed

curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz
sudo tar -C /usr -xzf ollama-linux-amd64.tgz

ollama -v

sleep 5



# Edit services
sudo tee /etc/systemd/system/ollama.service > /dev/null << 'EOF'
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/bin/ollama serve
User=vagrant
Group=vagrant
Restart=always
RestartSec=3
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
Environment="OLLAMA_HOST=0.0.0.0"

[Install]
WantedBy=default.target
EOF

sudo systemctl daemon-reload
sudo systemctl restart ollama

# Pull models
echo "Pulling models..."
ollama pull llama3.2         # Downloads the latest Llama 3 (8B by default)
ollama pull nomic-embed-text
ollama pull mxbai-embed-large
ollama pull bge-m3
ollama pull mistral         # Mistral 7B

# List installed models
echo "Installed models:"
ollama list


ps aux | grep ollama

# open http://127.0.0.1:11434  http://0.0.0.0:11434
# sudo systemctl edit ollama

# Environment="OLLAMA_HOST=0.0.0.0"
# sudo systemctl restart ollama

# kill Process
# sudo lsof -i :11434
# pkill ollama
