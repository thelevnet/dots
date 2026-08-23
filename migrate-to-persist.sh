#!/usr/bin/env bash
set -e

echo "==> Preparing /nix/persist directory structure..."
sudo mkdir -p /nix/persist/var/log
sudo mkdir -p /nix/persist/var/lib/nixos
sudo mkdir -p /nix/persist/var/lib/systemd
sudo mkdir -p /nix/persist/var/lib/bluetooth
sudo mkdir -p /nix/persist/var/lib/tailscale
sudo mkdir -p /nix/persist/etc/NetworkManager/system-connections
sudo mkdir -p /nix/persist/etc/nixos
sudo mkdir -p /nix/persist/etc/ssh
sudo mkdir -p /nix/persist/home/lev

echo "==> Copying system files & configuration..."
[ -f /etc/machine-id ] && sudo cp -a /etc/machine-id /nix/persist/etc/

for file in /etc/shadow /etc/passwd /etc/group /etc/gshadow; do
    if [ -f "$file" ]; then
        sudo cp -a "$file" /nix/persist/etc/
    fi
done

sudo cp -a /etc/ssh/ssh_host_* /nix/persist/etc/ssh/ 2>/dev/null || true

# Copy /etc/nixos repo cleanly
if [ -d /etc/nixos ]; then
    sudo cp -aT /etc/nixos /nix/persist/etc/nixos
fi

# Copy system service data cleanly
if [ -d /var/lib/bluetooth ] && [ "$(ls -A /var/lib/bluetooth 2>/dev/null)" ]; then
    sudo cp -aT /var/lib/bluetooth /nix/persist/var/lib/bluetooth
fi

if [ -d /var/lib/tailscale ] && [ "$(ls -A /var/lib/tailscale 2>/dev/null)" ]; then
    sudo cp -aT /var/lib/tailscale /nix/persist/var/lib/tailscale
fi

if [ -d /etc/NetworkManager/system-connections ] && [ "$(ls -A /etc/NetworkManager/system-connections 2>/dev/null)" ]; then
    sudo cp -aT /etc/NetworkManager/system-connections /nix/persist/etc/NetworkManager/system-connections
fi

echo "==> Copying user files & Antigravity data for 'lev'..."
for target in Downloads Pictures Projects .gemini .gnupg .ssh .local .cache .zsh_history .gitconfig; do
    if [ -e "/home/lev/$target" ]; then
        echo "    Copying /home/lev/$target..."
        sudo cp -a "/home/lev/$target" /nix/persist/home/lev/ 2>/dev/null || true
    fi
done

echo "==> Setting ownership..."
sudo chown -R lev:users /nix/persist/home/lev

echo "========================================================="
echo " [✓] Persist migration directory prepped successfully!"
echo "========================================================="
