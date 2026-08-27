{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.hyprland.nixosModules.default
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
      "https://noctalia.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7HPp25M08YA5olXY05H0z558g43bE5zBvgD8sbJPQM="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3FS="
    ];
    builders-use-substitutes = true;
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
    bat
    fastfetch
    eza
    kdePackages.filelight
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
    (llama-cpp.override { vulkanSupport = true; })
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
