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
  users.users.lev = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.zsh;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "colored-man-pages"
      ];
    };

    shellAliases = {
      ls = "eza --icons --group-directories-first";
      ll = "eza -lh --icons --grid --group-directories-first";
      la = "eza -a --icons --group-directories-first";
      lt = "eza --tree --level=2 --icons";
      imperio = "sudo ";
    };

    interactiveShellInit = ''
      fpath+=(/home/lev/.zsh/completions)
      autoload -U compinit && compinit
      
      text() {
        print -P "%{\e[36m%}%{\e[0m%}%{\e[46m\e[37m%}SYS%{\e[0m%}%{\e[0m%}%{\e[36m%}%{\e[0m%} $1"
      }

      text "fastfetch"
      fastfetch
      text "こんにちは、レフ！"
      echo

      MY_TOP_PROMPT=$'%{\e[36m%}%{\e[0m%}%{\e[46m\e[37m%}󰉋 %~%{\e[0m%}%{\e[36m%}%{\e[0m%} %{\e[36m%} %{\e[0m%}'
      MY_RPROMPT=$'%{\e[36m%}%{\e[0m%}%{\e[46m\e[37m%}%D{%H:%M}%{\e[0m%}%{\e[36m%}%{\e[0m%} %{\e[36m%}%{\e[0m%}%{\e[46m\e[37m%} %{\e[0m%}%{\e[36m%}%{\e[0m%}'
      MY_BOTTOM_PROMPT=$'%{\e[36m%} %{\e[0m%}'

      PROMPT=$MY_TOP_PROMPT
      RPROMPT=$MY_RPROMPT

      _my_accept_line() {
        PROMPT=$MY_BOTTOM_PROMPT
        RPROMPT=\'\'
        zle reset-prompt
        zle .accept-line
      }
      zle -N accept-line _my_accept_line

      preexec() {
        PROMPT=$MY_BOTTOM_PROMPT
        RPROMPT=\'\'
      }

      precmd() {
        PROMPT=$MY_TOP_PROMPT
        RPROMPT=$MY_RPROMPT
      }

      refresh_prompt() {
        zle && zle reset-prompt
      }

      TMOUT=60
      TRAPALRM() {
        refresh_prompt
      }
    '';
  };

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
    next = "/home/lev/Projects/Rust/next/target/release/next ";
  };

  # ── Desktop ──────────────────────────────────────────────────────────
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.dbus.enable = true;
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7HPp25M08YA5olXY05H0z558g43bE5zBvgD8sbJPQM=" ];
  };
  # ── System ───────────────────────────────────────────────────────────
  system.stateVersion = "26.05";
}
