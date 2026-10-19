{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  options.modules.minecraft = {
    enable = lib.mkEnableOption "Minecraft server";
  };

  config = lib.mkIf config.modules.minecraft.enable {
    networking.firewall.allowedTCPPorts = [ 8100 ];

    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;

      servers.server = {
        enable = true;
        autoStart = true;
        package = pkgs.paperServers.paper-26_1_2;
        jvmOpts = "-Xmx4G -Xms2G";
        serverProperties = {
          server-port = 25565;
          difficulty = "normal";
          gamemode = "survival";
          motd = "Main Server";
          online-mode = false;
          view-distance = 32;
          simulation-distance = 32;
        };
        symlinks = {
          "plugins/BlueMap.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/swbUV1cr/versions/uHQIrUdf/bluemap-5.29-paper.jar";
            sha512 = "e936198eaf7ea83429e1d08b8e2a5447dd359c0252e3410cb3cc101860c933abcc055462a11b034a4dd77b699da54017412ac73728860fd8b68a672c32d9926c";
          };
        };
        files = {
          "plugins/BlueMap/core.conf" = pkgs.writeText "core.conf" ''
            accept-download: true
          '';
        };
      };
      servers.server-2= {
        enable = true;
        autoStart = true;
        package = pkgs.vanillaServers.vanilla-26_1_2;
        jvmOpts = "-Xmx4G -Xms2G";
        serverProperties = {
          server-port = 25566;
          difficulty = "normal";
          gamemode = "creative";
          motd = "Second Server";
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
            ${pkgs.rclone}/bin/rclone --config ${config.sops.secrets."rclone_conf".path} \
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
  };
}
