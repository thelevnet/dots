{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  home = {
    username = "termux";
    homeDirectory = "/data/data/com.termux/files/home";

    # Phone-specific packages
    packages = with pkgs; [
      openssh
    ];
  };
}
