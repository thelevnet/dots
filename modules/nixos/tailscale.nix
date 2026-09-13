{ config, pkgs, lib, ... }:

{
  options.modules.tailscale = {
    enable = lib.mkEnableOption "Tailscale VPN service";
  };

  config = lib.mkIf config.modules.tailscale.enable {
    services.tailscale.enable = true;
  };
}
