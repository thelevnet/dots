{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

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
}
