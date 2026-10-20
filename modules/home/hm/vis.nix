{ config, lib, pkgs, ... }:

let
  cfg = config.programs.vis;

  mkCommand = k: v:
    if lib.isBool v then
      (if v then "  vis:command('set ${k}')" else "  vis:command('set no${k}')")
    else
      "  vis:command('set ${k} ${toString v}')";

  commands = lib.concatStringsSep "\n" (lib.mapAttrsToList mkCommand cfg.settings);
in
{
  options.programs.vis = {
    enable = lib.mkEnableOption "Vis text editor";

    package = lib.mkPackageOption pkgs "vis" { };

    defaultEditor = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to configure vis as the default editor.";
    };

    settings = lib.mkOption {
      type = with lib.types; attrsOf (oneOf [ bool int str ]);
      default = { };
      description = "Vis editor settings.";
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra configuration for visrc.lua.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.sessionVariables = lib.mkIf cfg.defaultEditor {
      EDITOR = "vis";
      VISUAL = "vis";
    };

    xdg.configFile."vis/visrc.lua".text = ''
      require('vis')

      vis.events.subscribe(vis.events.WIN_OPEN, function(win)
      ${commands}
      end)
      ${cfg.extraConfig}
    '';
  };
}
