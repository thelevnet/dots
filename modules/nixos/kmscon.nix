{ config, pkgs, lib, ... }:

{
  options.modules.kmscon = {
    enable = lib.mkEnableOption "KMSCon modern virtual console terminal";
  };

  config = lib.mkIf config.modules.kmscon.enable {
    fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

    services.kmscon = {
      enable = true;
      useXkbConfig = true;
      extraOptions = "--configdir /run/kmscon";
      config = {
        hwaccel = true;
        term = "xterm-256color";
        font-name = "JetBrainsMono Nerd Font";
        font-size = lib.mkForce 24;
        font-dpi = 96;
      };
    };

    systemd.services."kmsconvt@" = {
      serviceConfig.ExecStartPre = pkgs.writeShellScript "kmscon-prepare-config" ''
        mkdir -p /run/kmscon
        cat << 'EOF' > /run/kmscon/kmscon.conf
        hwaccel
        term=xterm-256color
        font-name=JetBrainsMono Nerd Font
        font-size=24
        font-dpi=96
        EOF
      '';
    };
  };
}
