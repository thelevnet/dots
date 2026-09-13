{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware.nix
    ../common
  ];

  networking.hostName = "laptop";

  # Enabled modules
  modules = {
    hyprland.enable = true;
    tailscale.enable = true;
  };

  # Boot loader & kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "i2c-dev" "asus-nb-wmi" "8821au" ];
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821au ];

  # Completely cut power to NVIDIA dGPU and blacklist modules
  boot.kernelParams = [
    "module_blacklist=nouveau,nvidia,nvidia_drm,nvidia_modeset,nvidia_uvm,mt7921e,mt7921s,mt7921u,mt7921_common,mt76"
  ];
  boot.blacklistedKernelModules = [
    # NVIDIA
    "nouveau"
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia_uvm"

    # MediaTek MT7921 / MT76
    "mt7921e"
    "mt7921s"
    "mt7921u"
    "mt7921_common"
    "mt792x_lib"
    "mt792x_usb"
    "mt76_connac_lib"
    "mt76"
  ];
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0

    # MediaTek MT7921
    blacklist mt7921e
    blacklist mt7921s
    blacklist mt7921u
    blacklist mt7921_common
    blacklist mt792x_lib
    blacklist mt792x_usb
    blacklist mt76_connac_lib
    blacklist mt76
  '';

  # Power Management & Battery
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  powerManagement.enable = true;

  # Udev rules to remove NVIDIA & MediaTek PCIe devices and enforce runtime power management
  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA VGA/3D controller devices
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"

    # Remove MediaTek MT7921 PCIe Wi-Fi card (vendor 0x14c3)
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x14c3", ATTR{power/control}="auto", ATTR{remove}="1"
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
