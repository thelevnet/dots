{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.hyprland.nixosModules.default
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nix-minecraft.overlays.default
    (final: prev: {
      next = inputs.next.packages.${prev.stdenv.hostPlatform.system}.default;
      noctalia = inputs.noctalia.packages.${prev.stdenv.hostPlatform.system}.default;
      zen-browser = inputs.zen-browser.packages.${prev.stdenv.hostPlatform.system}.default;
    })
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.kernelModules = [ "i2c-dev" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.bluetooth.enable = true;

  networking.hostName = "nix";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  services.tailscale.enable = true;
  services.blueman.enable = true;


  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.server = {
      enable = true;
      autoStart = true;
      package = pkgs.vanillaServers.vanilla-1_21_11;
      jvmOpts = "-Xmx4G -Xms2G";
      serverProperties = {
        server-port = 25565;
        difficulty = "normal";
        gamemode = "survival";
        motd = "Main Server";
        online-mode = false;
      };
    };
  };

  systemd.services.minecraft-cloud-sync = {
    description = "Sync Minecraft world to Google Drive";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "minecraft-cloud-sync" ''
        if [ -d "/srv/minecraft/server/world" ]; then
          ${pkgs.rclone}/bin/rclone --config /home/lev/.config/rclone/rclone.conf \
            sync /srv/minecraft/server/world gdrive:MinecraftBackups/server/world --fast-list -q
        fi
      '';
    };
  };

  systemd.timers.minecraft-cloud-sync = {
    description = "Sync Minecraft worlds to Google Drive every 15 minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "2m";
      OnUnitActiveSec = "15m";
      Persistent = true;
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  security.rtkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  users.users.lev = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "minecraft" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    #next start
		dust
    antigravity-cli
    zen-browser
    libnotify
    fetch
    next
    jq
    home-manager
    gcc
    fzf
    portablemc
    nh
    rustup
    git
    gh
    rclone
    bat
    fastfetch
    eza
    kitty
    yazi
    telegram-desktop
    neovim
    tmux
    stylua
    noctalia
    bibata-cursors
    lua-language-server
    qrencode
    #next end
  ];

  environment.shellAliases = {
    ls = "eza --icons --group-directories-first";
    la = "eza -a --icons --group-directories-first";
    lt = "eza --tree --level=4";
    imperio = "sudo ";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  programs.nix-ld.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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

    shellInit = ''
      fpath=(/home/lev/.zsh/completions $fpath)
      zsh-newuser-install() { :; }
    '';

    interactiveShellInit = ''
      text() {
        print -P "%{\e[32m%}%{\e[0m%}%{\e[42m\e[37m%}SYS%{\e[0m%}%{\e[0m%}%{\e[32m%}%{\e[0m%} $1"
      }
      clear
      text "fastfetch"
      fastfetch
      text "こんにちは、レフ！"
      echo

      MY_TOP_PROMPT=$'%{\e[32m%}%{\e[0m%}%{\e[42m\e[37m%}󰉋 %~%{\e[0m%}%{\e[32m%}%{\e[0m%} %{\e[32m%} %{\e[0m%}'
      MY_RPROMPT=$'%{\e[32m%}%{\e[0m%}%{\e[42m\e[37m%}%D{%H:%M}%{\e[0m%}%{\e[32m%}%{\e[0m%} %{\e[32m%}%{\e[0m%}%{\e[42m\e[37m%} %{\e[0m%}%{\e[32m%}%{\e[0m%}'
      MY_BOTTOM_PROMPT=$'%{\e[32m%} %{\e[0m%}'

      PROMPT=$MY_TOP_PROMPT
      RPROMPT=$MY_RPROMPT

      _my_accept_line() {
        PROMPT=$MY_BOTTOM_PROMPT
        RPROMPT=""
        zle reset-prompt
        zle .accept-line
      }
      zle -N accept-line _my_accept_line

      preexec() {
        PROMPT=$MY_BOTTOM_PROMPT
        RPROMPT=""
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

  system.stateVersion = "26.05";
}
