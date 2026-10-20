{ config, lib, ... }:

{
  options.modules.obsidian = {
    enable = lib.mkEnableOption "Obsidian MD Notes";
  };
  config = lib.mkIf config.modules.obsidian.enable {
    programs.obsidian = {
      enable = true;
      vaults.notes.target = "Documents/Obsidian";
    };
  };
}

