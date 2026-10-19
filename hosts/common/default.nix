{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules/nixos
  ];

  # Enabled base modules across all NixOS hosts
  modules = {
    sops.enable = lib.mkDefault true;
    niri.enable = lib.mkDefault true;
    tailscale.enable = lib.mkDefault true;
    kmscon.enable = lib.mkDefault true;
  };

  # Nix Package Manager settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    trusted-users = [ "root" "@wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import ../../overlays { inherit inputs; };

  # Common Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "i2c-dev" ];

  # Common Hardware Features
  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

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
  users.mutableUsers = false;
  users.users.root = {
    hashedPasswordFile = config.sops.secrets."lev-password".path;
  };
  users.users.lev = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."lev-password".path;
    extraGroups = [ "networkmanager" "wheel" "video" "minecraft" "plugdev" "dialout" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcoLI6VTUqHm8P5yMxiKC6JOPTKEQilSDDTkIjYPM+K"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDglM3KkmmhO3cyfwF1Ak6yTvo8MI5bqsH60fx6/CbOE phone"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIECgyKkx+dWGQTvgGkX7S1lDOERP+F0ooESGX+vfG10v laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+cZp5jhYJbvkFuoN0evWdId76IJ8mfDZP/C7akyacr desktop"
    ];
  };

  # Android flashing / mtkclient
  users.groups.plugdev = {};
  services.udev.extraRules = ''
    # MediaTek BootROM / preloader / DA modes (mtkclient)
    ATTRS{idVendor}=="0e8d", ENV{ID_MM_DEVICE_IGNORE}="1"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0e8d", MODE="0660", GROUP="plugdev", TAG+="uaccess"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="0e8d", MODE="0660", GROUP="dialout", TAG+="uaccess"
    KERNEL=="ttyUSB*", ATTRS{idVendor}=="0e8d", MODE="0660", GROUP="dialout", TAG+="uaccess"
    # Fastboot (Google / Xiaomi)
    SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", MODE="0660", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2717", MODE="0660", GROUP="plugdev", TAG+="uaccess"
  '';
  boot.blacklistedKernelModules = [ "cdc_acm" "option" "usb_wwan" ];

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

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "dur_file";
      dur_file_path = "${../../assets/ly/blackhole.dur}";
      dur_offset_alignment = "center";
      full_color = true;
    };
  };

  # Home Manager Integration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = false;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
  };


  system.stateVersion = "26.05";
}
