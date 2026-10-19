{ config, pkgs, inputs, ... }:

{
  programs.obsidian = {
    enable = true;
    vaults.notes.target = "Documents/Obsidian";
  };
}

