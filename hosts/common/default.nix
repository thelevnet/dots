{ pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules/nixos
  ];

  # Enabled base modules
  modules.sops.enable = lib.mkDefault true;

  # Nix Package Manager settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import ../../overlays { inherit inputs; };

  # Memory & ZRAM
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 5;
  };

  # Localization & Time
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # Networking
  networking.networkmanager.enable = true;

  # Audio & Realtime
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;

  # SSH
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # System User
  users.users.lev = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "minecraft" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcoLI6VTUqHm8P5yMxiKC6JOPTKEQilSDDTkIjYPM+K"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDglM3KkmmhO3cyfwF1Ak6yTvo8MI5bqsH60fx6/CbOE phone"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIECgyKkx+dWGQTvgGkX7S1lDOERP+F0ooESGX+vfG10v laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+cZp5jhYJbvkFuoN0evWdId76IJ8mfDZP/C7akyacr desktop"
    ];
  };

  # Shell registration & Dynamic Linker support
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  # Base System Packages
  environment.systemPackages = with pkgs; [
    git
    home-manager
    next
  ];

  # Home Manager Integration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };

  system.stateVersion = "26.05";
}
