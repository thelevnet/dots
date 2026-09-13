{ pkgs, ... }:

{
  home = {
    username = "termux";
    homeDirectory = "/data/data/com.termux/files/home";
    stateVersion = "26.05";

    packages = with pkgs; [
      openssh
      antigravity-cli
      git
      gh
      bat
      eza
      yazi
    ];
  };

  programs.home-manager.enable = true;
}
