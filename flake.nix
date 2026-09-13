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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations."desktop" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/desktop
      ];
    };

    nixosConfigurations."laptop" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/laptop
      ];
    };

    homeConfigurations = let
      mkPhone = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
          overlays = import ./overlays { inherit inputs; };
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./users/lev/phone.nix ];
      };

      mkWorkstation = userModule: inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = import ./overlays { inherit inputs; };
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [
          userModule
          ({ pkgs, ... }: {
            modules = {
              hyprland.enable = true;
              noctalia.enable = true;
              kitty.enable = true;
              fastfetch.enable = true;
              zsh.enable = true;
              starship.enable = true;
              neovim.enable = true;
              theme.enable = true;
            };
            home.packages = with pkgs; [
              zen-browser
              telegram-desktop
              portablemc
              bibata-cursors
              zoxide
              fetch
              qrencode
            ];
          })
        ];
      };
    in {
      "phone" = mkPhone;
      "termux" = mkPhone;
      "lev@desktop" = mkWorkstation ./users/lev/desktop.nix;
      "lev@laptop" = mkWorkstation ./users/lev/laptop.nix;
      "lev" = mkWorkstation ./users/lev/desktop.nix;
    };

    devShells = let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
    in forAllSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = pkgs.mkShell {
          name = "nixos-config-dev";
          packages = with pkgs; [
            git
            gh
            nh
            nix-output-monitor
            nvd
            nil
            nixfmt
            alejandra
            statix
            deadnix
            sops
            age
            ripgrep
            fd
            fzf
            jq
          ];
          shellHook = ''
            echo "Entering NixOS configuration environment in $(pwd)"
          '';
        };
      }
    );
  };
}

