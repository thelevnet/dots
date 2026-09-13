{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.modules.sops = {
    enable = lib.mkEnableOption "SOPS secret management";
  };

  config = lib.mkIf config.modules.sops.enable {
    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets."gh_hosts" = {
        mode = "0600";
        owner = "lev";
        group = "users";
        path = "/home/lev/.config/gh/hosts.yml";
      };

      secrets."rclone_conf" = {
        mode = "0600";
        owner = "lev";
        group = "users";
        path = "/home/lev/.config/rclone/rclone.conf";
      };
    };

    environment.systemPackages = with pkgs; [
      sops
      age
      ssh-to-age
    ];
  };
}
