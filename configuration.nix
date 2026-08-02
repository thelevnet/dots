{ config, pkgs, inputs, lib, ... }:

let
  quickshellWrapped = pkgs.symlinkJoin {
    name = "quickshell-wrapped";
    paths = [ inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      for binary in quickshell qs; do
        if [ -f "$out/bin/$binary" ]; then
          wrapProgram "$out/bin/$binary" \
            --prefix QML2_IMPORT_PATH : "${lib.makeSearchPath "lib/qt-6/qml" [
              pkgs.kdePackages.qtpositioning
              pkgs.kdePackages.qtbase
              pkgs.kdePackages.qtdeclarative
              pkgs.kdePackages.qtmultimedia
              pkgs.kdePackages.qtsensors
              pkgs.kdePackages.qtsvg
              pkgs.kdePackages.qtwayland
              pkgs.kdePackages.qt5compat
              pkgs.kdePackages.qtimageformats
              pkgs.kdePackages.qtquicktimeline
              pkgs.kdePackages.qtwebsockets
              pkgs.kdePackages.kirigami.unwrapped
              pkgs.kdePackages.syntax-highlighting
            ]}" \
            --prefix QT_PLUGIN_PATH : "${lib.makeSearchPath "lib/qt-6/plugins" [
              pkgs.kdePackages.qtbase
              pkgs.kdePackages.qtsvg
              pkgs.kdePackages.qtwayland
              pkgs.kdePackages.qtimageformats
            ]}" \
            --prefix XDG_DATA_DIRS : "$XDG_DATA_DIRS:/run/current-system/sw/share"
        fi
      done
    '';
  };
in 
{
  _module.args = { inherit quickshellWrapped; };
  imports = [
    ./hardware-configuration.nix
      inputs.hyprland.nixosModules.default
    ./apps.nix
  ];

# ── Paths and Linking ─────────────────────────────────────────────────
  environment.pathsToLink = [ "/share/gsettings-schemas" "/share/icons" ];

# ── Boot & Hardware ───────────────────────────────────────────────────
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8821au
  ];
  boot.blacklistedKernelModules = [ "mt7921e" "mt7921u" "mt7921s" ];
  boot.kernelModules = [ "i2c-dev" "uinput" ];
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  # Ensure unfree is allowed



# 2. Set Video Drivers
services.xserver.videoDrivers = [ "nvidia" ];

# 3. Configure NVIDIA Hardware
hardware.nvidia = {
  modesetting.enable = true;
  # Use 'true' for newer cards (RTX 20-series and newer), 'false' for older
  open = true; 
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;

  prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    amdgpuBusId = "PCI:5:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };
};

# 4. Ensure Graphics Support is enabled
hardware.graphics = {
  enable = true;
  enable32Bit = true;
};
services.xserver = {
  enable = true;
  # Disable automatic display manager/window manager startup
  autorun = false;
  displayManager.startx.enable = true;
};
services.playit = {
  enable = true;
  # Force the module to use your dedicated directory, bypassing systemd-credentials
  secretPath = "/var/lib/playit/playit.toml";
};
# ── Network & Locale ──────────────────────────────────────────────────
  networking.hostName = "neto";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

# ── Users & Shells ────────────────────────────────────────────────────
  users.users.refu = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "input" "i2c" "libvirtd" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  virtualisation.vmVariant = {
    services.getty.autologinUser = "refu";
    virtualisation.qemu.options = [ "-vga virtio" ];
    environment.sessionVariables.WLR_RENDERER_ALLOW_SOFTWARE = "1";
    environment.sessionVariables.LIBGL_ALWAYS_SOFTWARE = "1";
  };


# ── System Services ───────────────────────────────────────────────────
  services.udev.extraRules = ''
    SUBSYSTEM=="misc", KERNEL=="uinput", MODE="0660", GROUP="input"
    '';
   services.blueman.enable = true;
   hardware.bluetooth.enable = true;
  systemd.user.services.ydotool = {
    description = "ydotool daemon";
    wantedBy = [ "default.target" ];
    serviceConfig = { ExecStart = "${pkgs.ydotool}/bin/ydotoold"; };
  };

# ── Packages ──────────────────────────────────────────────────────────
  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;
  fonts = {
    packages = with pkgs; [
      material-symbols
        nerd-fonts.jetbrains-mono
    ];
    fontDir.enable = true; # Важно для кэширования
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
# Add the libraries GLFW/LWJGL needs
      libx11
      libxcursor
      libxrandr
      libxext
      libGL
      libGLU
      glfw
      mesa
  ];

# ── Environment Variables ─────────────────────────────────────────────
  environment.variables = {
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/glib-2.0/schemas";
    ILLOGICAL_IMPULSE_VIRTUAL_ENV = "/home/refu/.local/state/quickshell/.venv";
    NIX_CONFIG = "experimental-features = nix-command flakes";
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_DATA_DIRS = lib.mkForce "$HOME/.nix-profile/share:/etc/profiles/per-user/refu/share:/run/current-system/sw/share";  
  };

  environment.shellAliases = {
    n = "nvim ";
    nixdt = "nvim /etc/nixos/configuration.nix";
    inst = "nvim /etc/nixos/apps.nix";
    nixup = "sudo nixos-rebuild switch --flake /etc/nixos#neto";
    jcommet = "java /home/refu/Projects/Java/JCommet/src/com/app/Main.java";
    next = "/home/refu/Projects/Rust/next/target/release/next ";
  };

# ── Desktop ───────────────────────────────────────────────────────────
  services.pipewire = { enable = true; alsa.enable = true; pulse.enable = true; };
  programs.hyprland.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

# ── Home Manager ──────────────────────────────────────────────────────
  system.stateVersion = "26.05";
}
