{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  home = {
    username = "termux";
    homeDirectory = "/data/data/com.termux/files/home";

    packages = with pkgs; [
      openssh
    ];
  };
}
