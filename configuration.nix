{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.hyprland.nixosModules.default
    ./apps.nix
  ];

  # ── Boot & Hardware ──────────────────────────────────────────────────
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtl8821au ];
  boot.blacklistedKernelModules = [ "mt7921e" "mt7921u" "mt7921s" ];
  boot.kernelModules = [ "i2c-dev" ];
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.playit = {
    enable = true;
    secretPath = "/var/lib/playit/playit.toml";
  };

  # ── Network & Locale ─────────────────────────────────────────────────
  networking.hostName = "nix";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # ── Users & Shells ───────────────────────────────────────────────────
  users.users.refu = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  # ── System Services ──────────────────────────────────────────────────
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  # ── Packages ─────────────────────────────────────────────────────────
  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;

  # ── Environment ──────────────────────────────────────────────────────
  environment.variables = {
    NIX_CONFIG = "experimental-features = nix-command flakes";
  };
  environment.shellAliases = {
    next = "/home/refu/Projects/Rust/next/target/release/next ";
  };

  # ── Desktop ──────────────────────────────────────────────────────────
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  programs.hyprland.enable = true;

  # ── System ───────────────────────────────────────────────────────────
  system.stateVersion = "26.05";
}
