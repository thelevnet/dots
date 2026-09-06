{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    next = {
      url = "github:thelevnet/next";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations."desktop" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/desktop
      ];
    };

    homeConfigurations."lev" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = import ./overlays { inherit inputs; };
      };
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./users/lev ];
    };

    apps = let
      mkInstaller = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          installerScript = pkgs.writeShellScriptBin "install" ''
            set -e

            # Reconnect stdin to interactive terminal
            if [ ! -t 0 ] && [ -e /dev/tty ]; then
                exec < /dev/tty
            fi

            cd /tmp

            echo "========================================================="
            echo "               NIXOS CONFIG INSTALLER                    "
            echo "========================================================="
            echo

            if ! command -v nixos-rebuild &>/dev/null; then
                echo "[!] Error: 'nixos-rebuild' not found. This script must be run on a NixOS system."
                exit 1
            fi

            REAL_USER="''${SUDO_USER:-$USER}"
            REAL_GROUP=$(id -gn "$REAL_USER" 2>/dev/null || echo "users")
            REPO_URL="https://github.com/thelevnet/dots.git"

            echo "WARNING: This will replace your current /etc/nixos configuration"
            echo "         with the repository from ''${REPO_URL}"
            echo
            read -rp "Do you want to proceed with the installation? [y/N]: " CONFIRM
            if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
                echo "Installation aborted."
                exit 0
            fi

            echo

            echo "==> Cleaning existing /etc/nixos..."
            if [ -d "/etc/nixos" ]; then
                sudo rm -rf /etc/nixos
            fi

            echo "==> Cloning repository from ''${REPO_URL} into /etc/nixos..."
            sudo git clone "''${REPO_URL}" /etc/nixos

            echo "==> Removing existing hardware.nix..."
            sudo rm -f /etc/nixos/hosts/desktop/hardware.nix

            echo "==> Generating fresh hardware.nix for host 'desktop'..."
            sudo nixos-generate-config --show-hardware-config | sudo tee /etc/nixos/hosts/desktop/hardware.nix > /dev/null

            # Track hardware.nix in git so Nix Flakes can evaluate it
            sudo git -C /etc/nixos add -f hosts/desktop/hardware.nix

            echo "==> Setting ownership of /etc/nixos to ''${REAL_USER}:''${REAL_GROUP}..."
            sudo chown -R "''${REAL_USER}:''${REAL_GROUP}" /etc/nixos

            MAX_JOBS=4
            CORES_PER_JOB=4

            echo
            echo "==> Rebuilding and applying NixOS configuration..."
            echo "==> (Throttled to max-jobs=''${MAX_JOBS}, cores=''${CORES_PER_JOB} with low CPU priority to prevent freezing)"
            sudo nice -n 15 nixos-rebuild switch --flake /etc/nixos#desktop --max-jobs "$MAX_JOBS" --cores "$CORES_PER_JOB"

            echo
            echo "==> GitHub CLI authentication..."
            if command -v gh &>/dev/null; then
                sudo -u "$REAL_USER" gh auth login
            else
                echo "[!] Warning: 'gh' command not found. Skipping GitHub authentication."
            fi

            echo
            echo "========================================================="
            echo " [✓] NixOS configuration successfully installed and applied!"
            echo "========================================================="
          '';
        in {
          default = {
            type = "app";
            program = "${installerScript}/bin/install";
          };
          install = {
            type = "app";
            program = "${installerScript}/bin/install";
          };
        };
    in {
      x86_64-linux = mkInstaller "x86_64-linux";
      aarch64-linux = mkInstaller "aarch64-linux";
    };
  };
}
