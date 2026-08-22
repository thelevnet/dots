#!/usr/bin/env bash
set -e

echo "NVIDIA Fuck You"
echo

echo "========================================================="
echo "               NIXOS CONFIG & INSTALLER                 "
echo "========================================================="
echo "1) Apply Config on Existing System (nixos-rebuild switch)"
echo "2) Fresh Install from Live USB ISO (partition + nixos-install)"
echo "3) Exit"
echo "========================================================="
read -rp "Select an option [1-3] (Default: 1): " MODE
MODE=${MODE:-1}

if [[ "$MODE" == "3" ]]; then
    echo "Exiting."
    exit 0
fi

# -------------------------------------------------------------
# MODE 1: APPLY CONFIG ON RUNNING NIXOS
# -------------------------------------------------------------
if [[ "$MODE" == "1" ]]; then
    echo
    echo "==> Applying dots configuration to current system..."
    
    if ! command -v nixos-rebuild &>/dev/null; then
        echo "[!] Error: nixos-rebuild not found. Are you in a live USB installer? If so, select option 2."
        exit 1
    fi

    # Ensure /etc/nixos exists
    sudo mkdir -p /etc/nixos

    # Backup existing hardware-configuration if present
    if [ -f "/etc/nixos/hardware-configuration.nix" ]; then
        echo "==> Preserving local hardware-configuration.nix..."
        sudo cp /etc/nixos/hardware-configuration.nix /tmp/hardware-configuration.nix
    fi

    # Clone or update dots in /etc/nixos
    if [ -d "/etc/nixos/.git" ]; then
        echo "==> Updating /etc/nixos from Git..."
        sudo git -C /etc/nixos pull --rebase
    else
        echo "==> Cloning dots to /etc/nixos..."
        sudo rm -rf /etc/nixos/*
        sudo git clone https://github.com/thelevnet/dots /etc/nixos
    fi

    # Restore hardware configuration
    if [ -f "/tmp/hardware-configuration.nix" ]; then
        sudo cp /tmp/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
    fi

    echo "==> Rebuilding and switching NixOS configuration..."
    sudo nixos-rebuild switch --flake /etc/nixos#nix

    echo
    echo "========================================================="
    echo " [✓] System & Home Manager applied successfully!"
    echo "========================================================="
    exit 0
fi

# -------------------------------------------------------------
# MODE 2: FRESH INSTALL FROM LIVE ISO
# -------------------------------------------------------------
if [[ "$MODE" == "2" ]]; then
    if [[ $EUID -ne 0 ]]; then
        echo "[!] Please run fresh installation as root (sudo bash install.sh)."
        exit 1
    fi

    echo
    echo "==================== AVAILABLE DISKS ===================="
    lsblk -d -o NAME,SIZE,MODEL,TYPE | grep -E "disk|NAME"
    echo "========================================================="
    echo

    read -rp "Enter target drive [/dev/nvme0n1]: " TARGET_DISK
    TARGET_DISK=${TARGET_DISK:-/dev/nvme0n1}

    if [[ ! -b "$TARGET_DISK" ]]; then
        echo "[!] Error: Disk $TARGET_DISK not found!"
        exit 1
    fi

    echo
    echo "[!] WARNING: ALL DATA ON $TARGET_DISK WILL BE DESTROYED!"
    read -rp "Type 'YES' to format $TARGET_DISK and proceed: " FINAL_CHECK
    if [[ "$FINAL_CHECK" != "YES" ]]; then
        echo "Aborted."
        exit 0
    fi

    echo "==> Partitioning $TARGET_DISK (1GB EFI, 100% Root)..."
    wipefs -a "$TARGET_DISK"
    parted -s "$TARGET_DISK" -- mklabel gpt
    parted -s "$TARGET_DISK" -- mkpart ESP fat32 1MiB 1024MiB
    parted -s "$TARGET_DISK" -- set 1 esp on
    parted -s "$TARGET_DISK" -- mkpart primary ext4 1024MiB 100%

    if [[ "$TARGET_DISK" =~ [0-9]$ ]]; then
        BOOT_PART="${TARGET_DISK}p1"
        ROOT_PART="${TARGET_DISK}p2"
    else
        BOOT_PART="${TARGET_DISK}1"
        ROOT_PART="${TARGET_DISK}2"
    fi

    echo "==> Formatting partitions..."
    mkfs.fat -F 32 -n BOOT "$BOOT_PART"
    mkfs.ext4 -F -L nixos "$ROOT_PART"

    echo "==> Mounting filesystems..."
    mkdir -p /mnt
    mount "$ROOT_PART" /mnt
    mkdir -p /mnt/boot
    mount "$BOOT_PART" /mnt/boot

    echo "==> Generating hardware configuration..."
    nixos-generate-config --root /mnt
    cp /mnt/etc/nixos/hardware-configuration.nix /tmp/hardware-configuration.nix

    echo "==> Cloning dotfiles..."
    mkdir -p /mnt/etc
    rm -rf /mnt/etc/nixos
    git clone https://github.com/thelevnet/dots /mnt/etc/nixos
    cp /tmp/hardware-configuration.nix /mnt/etc/nixos/hardware-configuration.nix

    echo "==> Running nixos-install..."
    nixos-install --flake /mnt/etc/nixos#nix

    echo
    echo "========================================================="
    echo " [✓] Installation complete! You can now reboot into NixOS."
    echo "========================================================="
    read -rp "Reboot now? [y/N]: " REBOOT_NOW
    if [[ "$REBOOT_NOW" =~ ^[Yy]$ ]]; then
        reboot
    fi
fi
