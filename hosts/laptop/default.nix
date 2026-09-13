{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware.nix
    ../common
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/tailscale.nix
  ];

  networking.hostName = "laptop";

  # Boot loader & kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "i2c-dev" "asus-nb-wmi" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Completely cut power to NVIDIA dGPU and blacklist modules
  boot.kernelParams = [
    "module_blacklist=nouveau,nvidia,nvidia_drm,nvidia_modeset,nvidia_uvm"
  ];
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia_uvm"
  ];
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';

  # Power Management & Battery
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  powerManagement.enable = true;

  # Udev rules to remove NVIDIA PCIe devices and enforce runtime power management
  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA VGA/3D controller devices
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';

  # ASUS hardware EC power-cut for dGPU at startup & resume
  systemd.services.asus-dgpu-disable = {
    description = "Disable ASUS dGPU on boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.bash}/bin/bash -c 'if [ -w /sys/devices/platform/asus-nb-wmi/dgpu_disable ]; then echo 1 > /sys/devices/platform/asus-nb-wmi/dgpu_disable; fi'";
    };
  };

  systemd.services.asus-dgpu-disable-resume = {
    description = "Disable ASUS dGPU after resume";
    wantedBy = [ "sleep.target" ];
    before = [ "sleep.target" ];
    unitConfig.StopWhenUnneeded = true;
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "${pkgs.bash}/bin/bash -c 'if [ -w /sys/devices/platform/asus-nb-wmi/dgpu_disable ]; then echo 1 > /sys/devices/platform/asus-nb-wmi/dgpu_disable; fi'";
    };
  };

  # Hardware features
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # User profile
  home-manager.users.lev = import ../../users/lev/laptop.nix;
}
