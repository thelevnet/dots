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
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    environmentVariables = {
      HSA_OVERRIDE_GFX_VERSION = "11.0.0";
      OLLAMA_KEEP_ALIVE = "2m";
      LLAMA_ARG_FIT = "off";
    };
  };

  networking.firewall.allowedTCPPorts = [ 25565 25566 ];
  networking.firewall.allowedUDPPorts = [ 25565 25566 ];

  systemd.services.mc-server = {
    description = "Minecraft Main Server";
    serviceConfig = {
      Type = "simple";
      User = "lev";
      WorkingDirectory = "/home/lev/.minecraft/server";
      ExecStart = "${pkgs.temurin-bin-21}/bin/java -Xmx4G -Xms2G -jar server.jar nogui";
      Restart = "no";
    };
  };

  systemd.services.mc-second-server = {
    description = "Minecraft Second Server";
    serviceConfig = {
      Type = "simple";
      User = "lev";
      WorkingDirectory = "/home/lev/.minecraft/second-server";
      ExecStart = "${pkgs.temurin-bin-21}/bin/java -Xmx4G -Xms2G -jar server.jar nogui";
      Restart = "no";
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
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
    ];
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
    extraGroups = [ "networkmanager" "wheel" "video" ];
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
    bat
    fastfetch
    eza
    kitty
    yazi
    telegram-desktop
    neovim
    #next dependencies
    stylua
    noctalia
    nerd-fonts.jetbrains-mono
    bibata-cursors
    lua-language-server
    qrencode
    ollama
    #next end
  ];

  environment.shellAliases = {
    ls = "eza --icons --group-directories-first";
    la = "eza -a --icons --group-directories-first";
    lt = "eza --tree --level=2 --icons";
    imperio = "sudo ";
    build-next = "/home/lev/Projects/Rust/next/target/release/next ";
    vox = "~/Projects/vox/target/release/vox";
    todo = "~/Projects/todo/target/release/todo";
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
      mkdir -p ~/.cache/zsh
      autoload -Uz compinit && compinit -d ~/.cache/zsh/zcompdump
      zsh-newuser-install() { :; }
    '';

    interactiveShellInit = ''
      text() {
        print -P "%{\e[36m%}%{\e[0m%}%{\e[46m\e[37m%}SYS%{\e[0m%}%{\e[0m%}%{\e[36m%}%{\e[0m%} $1"
      }
      clear
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
