{ config, pkgs, ... }:

{
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/var/lib/bluetooth"
      "/var/lib/tailscale"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
    ];
    files = [
      "/etc/machine-id"
      "/etc/shadow"
      "/etc/passwd"
      "/etc/group"
      "/etc/gshadow"
    ];
    users.lev = {
      directories = [
        "Downloads"
        "Pictures"
        "Projects"
        ".gemini"
        ".gnupg"
        ".ssh"
        ".local/share"
        ".local/state"
        ".cache"
        ".config/zen"
        ".mozilla"
        ".config/telegram-desktop"
      ];
      files = [
        ".zsh_history"
        ".gitconfig"
      ];
    };
  };

  # Ensure required persist directory structure exists on boot
  systemd.tmpfiles.rules = [
    "d /persist/var/log 0755 root root -"
    "d /persist/var/lib/nixos 0755 root root -"
    "d /persist/var/lib/systemd 0755 root root -"
    "d /persist/var/lib/bluetooth 0700 root root -"
    "d /persist/var/lib/tailscale 0700 root root -"
    "d /persist/etc/NetworkManager/system-connections 0700 root root -"
    "d /persist/etc/nixos 0755 root root -"
    "d /persist/home/lev 0700 lev users -"
  ];
}
