{ config, lib, ... }:

{
  options.modules.vis = {
    enable = lib.mkEnableOption "Vis text editor";
  };

  config = lib.mkIf config.modules.vis.enable {
    programs.vis = {
      enable = true;
      defaultEditor = true;

      settings = {
        relativenumber = true;
        cursorline = true;
        tabwidth = 2;
        expandtab = true;
        autoindent = true;
        show-tabs = true;
        show-whitespace = true;
      };
    };
  };
}
