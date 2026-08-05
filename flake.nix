{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
  };
  outputs = { self, nixpkgs, hyprland, playit-nixos-module, ... } @ inputs: {
    nixosConfigurations."nix" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        inputs.playit-nixos-module.nixosModules.default
        ./configuration.nix
      ];
    };
  };}
