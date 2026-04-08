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
echo ""
echo "Notes:"
echo "  • The email and URL whitelists are stored in a Google Sheet"
echo "    called 'Phelix - Configuration' on Phelix's Drive."
echo "    Phelix creates this automatically on first run and shares"
echo "    it with Oliver as editor."
echo "  • The Sheet ID is cached in ~/virtual-employee/phelix_config.json"
echo "    (gitignored — never pushed to GitHub)."
echo "  • To manage whitelists, email Phelix from Oliver's address, e.g.:"
echo "      'Add alice@example.com to whitelist'"
echo "      'Add https://example.com to research whitelist'"
