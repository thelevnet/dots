{ config, pkgs, quickshellWrapped,...}:
{
environment.systemPackages = with pkgs; [
    #next start
		python3
		kotlin
		swift
		viber
		fzf
		btop
    #next end
    portablemc
	  nh
    fd
    vlc
    libsForQt5.qtstyleplugin-kvantum
    rustup
    discord
    gcc
    vscode
    lua-language-server
    stylua
    unzip
    micro
    wget
    git
    python3
    bat
    gh
    nasm
    fastfetch
    eza
    lxsession
    gsettings-desktop-schemas
    glib
    quickshellWrapped
    upower
    papirus-icon-theme
    adwaita-icon-theme
    kdePackages.breeze-icons
    gnome-icon-theme
    hyprsunset
    hypridle
    kdePackages.filelight
    hyprpicker
    hyprshot
    wl-clipboard
    playerctl
    libnotify
    kitty
    fuzzel
    matugen
    bibata-cursors
    adw-gtk3
    darkly
    material-symbols
    nerd-fonts.jetbrains-mono
    rubik
    twemoji-color-font
    kdePackages.dolphin
    libcava
    lxqt.pavucontrol-qt
    wireplumber
    libdbusmenu-gtk3
    songrec
    slurp
    swappy
    wf-recorder
    tesseract
    imagemagick
    bc
    cliphist
    cmake
    curlFull
    ripgrep
    jq
    rsync
    yq-go
    xdg-user-dirs
    upower
    wtype
    ydotool
    translate-shell
    libqalculate
    uv
    gtk4
    libadwaita
    libsoup_3
    libportal-gtk4
    gobject-introspection
    fontconfig
    brightnessctl
    ddcutil
    google-chrome
    telegram-desktop
    grim
    cowsay
    cmatrix
    sl
    aseprite
    neovim
    (geoclue2.override { withDemoAgent = true; })
    (pkgs.writeShellApplication {
      name = "lns";
      runtimeInputs = [ pkgs.nasm pkgs.binutils ]; 
      text = ''
        if [ -z "$1" ]; then
          echo "Error: No filename provided."
          echo "Usage: build-asm <filename_without_extension>"
          exit 1
          fi
        
          nasm -f elf64 "$1.asm" -o temp.o
          ld -o "$1" temp.o
          rm temp.o
      '';
    })
];
}

