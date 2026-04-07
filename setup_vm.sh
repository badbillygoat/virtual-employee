#!/bin/bash
# Virtual Employee - VM Setup Script
# ====================================
# Run this once on a fresh VM to install all dependencies.
# Usage: bash setup_vm.sh

set -e  # exit on any error

echo "========================================"
echo "  Virtual Employee VM Setup"
echo "========================================"
echo ""

# 1. Update package list
echo "→ Updating package list..."
sudo apt-get update -q

# 2. Install Python pip and dependencies
echo "→ Installing Python packages..."
pip3 install --user \
    google-auth \
    google-auth-oauthlib \
    google-auth-httplib2 \
    google-api-python-client

# 3. Create project directory structure
echo "→ Creating ~/virtual-employee directory..."
mkdir -p ~/virtual-employee/logs

# 4. Done
echo ""
echo "========================================"
echo "  ✓ VM setup complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. Copy credentials.json to ~/virtual-employee/"
echo "  2. Run: python3 ~/virtual-employee/setup_oauth.py"
echo "  3. Install the systemd service"
