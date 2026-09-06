#!/usr/bin/env bash
set -e

# Reconnect stdin to interactive terminal (supports: curl -fsSL ... | bash)
if [ ! -t 0 ] && [ -e /dev/tty ]; then
    exec < /dev/tty
fi

# Ensure we're not inside /etc/nixos when removing it
cd /tmp

echo "========================================================="
echo "               NIXOS CONFIG INSTALLER                    "
echo "========================================================="
echo

# 1. Check if running on NixOS
if ! command -v nixos-rebuild &>/dev/null; then
    echo "[!] Error: 'nixos-rebuild' not found. This script must be run on a NixOS system."
    exit 1
fi

REAL_USER="${SUDO_USER:-$USER}"
REAL_GROUP=$(id -gn "$REAL_USER" 2>/dev/null || echo "users")
REPO_URL="https://github.com/thelevnet/dots.git"

echo "WARNING: This will replace your current /etc/nixos configuration"
echo "         with the repository from ${REPO_URL}"
echo "         A backup will be saved to /etc/nixos.bak"
echo
read -rp "Do you want to proceed with the installation? [y/N]: " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Installation aborted."
    exit 0
fi

echo

# 2. Clean old /etc/nixos and clone new repo
echo "==> Backing up and cleaning existing /etc/nixos..."
if [ -d "/etc/nixos" ]; then
    sudo rm -rf /etc/nixos.bak
    sudo cp -r /etc/nixos /etc/nixos.bak 2>/dev/null || true
    sudo rm -rf /etc/nixos
fi

echo "==> Cloning repository from ${REPO_URL} into /etc/nixos..."
sudo git clone "${REPO_URL}" /etc/nixos

# 3. Delete existing hardware-configuration.nix and generate a fresh one
echo "==> Removing existing hardware-configuration.nix..."
sudo rm -f /etc/nixos/hardware-configuration.nix

echo "==> Generating fresh hardware-configuration.nix for this machine..."
sudo nixos-generate-config --show-hardware-config | sudo tee /etc/nixos/hardware-configuration.nix > /dev/null

# Track hardware-configuration.nix in git so Nix Flakes can evaluate it
sudo git -C /etc/nixos add -f hardware-configuration.nix

# 4. Set ownership of /etc/nixos to regular user
echo "==> Setting ownership of /etc/nixos to ${REAL_USER}:${REAL_GROUP}..."
sudo chown -R "${REAL_USER}:${REAL_GROUP}" /etc/nixos

# 5. GitHub authentication
echo
echo "==> GitHub CLI authentication..."
if command -v gh &>/dev/null; then
    sudo -u "$REAL_USER" gh auth login
else
    echo "[!] Warning: 'gh' command not found. Skipping GitHub authentication."
fi

# 6. Build and apply NixOS system configuration
echo
echo "==> Rebuilding and applying NixOS configuration..."
sudo nixos-rebuild switch --flake /etc/nixos#nix

echo
echo "========================================================="
echo " [✓] NixOS configuration successfully installed and applied!"
echo "========================================================="
