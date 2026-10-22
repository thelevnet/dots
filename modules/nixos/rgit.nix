{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.rgit = {
    enable = lib.mkEnableOption "rgit self-hosted Git server";
  };

  config = lib.mkIf config.modules.rgit.enable {
    environment.systemPackages = [ pkgs.rgit ];

    nix.settings.plugin-files = [ "${pkgs.rgit}/lib/libnix_rg.so" ];

    networking.firewall.allowedTCPPorts = [ 9418 ];

    systemd.services.rgit = {
      description = "rgit self-hosted Git Smart HTTP & TUI server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      path = [ pkgs.git ];
      serviceConfig = {
        Type = "simple";
        User = "lev";
        Group = "users";
        ExecStart = "${pkgs.rgit}/bin/rgit serve --bind 0.0.0.0:9418 --dir ${config.home-manager.users.lev.xdg.dataHome}/rgit";
        Restart = "always";
        RestartSec = 2;
      };
    };
  };
}
