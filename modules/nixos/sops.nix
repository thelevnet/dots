{ config, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets."example_secret" = {
      mode = "0440";
      owner = "lev";
      group = "users";
    };

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
}
