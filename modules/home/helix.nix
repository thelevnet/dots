{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.modules.helix = {
    enable = lib.mkEnableOption "Helix modal text editor";
  };

  config = lib.mkIf config.modules.helix.enable {
    stylix.targets.helix.enable = false;

    programs.helix = {
      enable = true;
      defaultEditor = true;

      extraPackages = with pkgs; [
        nil
        nixfmt
        rust-analyzer
      ];

      settings = {
        theme = "caelus";

        editor = {
          line-number = "relative";
          cursorline = true;
          scrolloff = 4;
          mouse = true;
          color-modes = true;
          auto-pairs = true;
          auto-save = false;
          idle-timeout = 50;
          completion-trigger-len = 1;
          bufferline = "multiple";
          true-color = true;

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          indent-guides = {
            render = true;
            character = "│";
            skip-levels = 1;
          };

          gutters = [
            "diagnostics"
            "line-numbers"
            "spacer"
            "diff"
          ];

          statusline = {
            left = [
              "mode"
              "spinner"
              "file-name"
              "read-only-indicator"
              "file-modification-indicator"
            ];
            center = [ ];
            right = [
              "diagnostics"
              "selections"
              "position"
              "file-encoding"
              "file-type"
            ];
            separator = "│";
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
          };

          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
        };

        keys.normal = {
          space.w = ":w";
          space.q = ":q";
          space.x = ":bc";

          g.n = ":buffer-next";
          g.p = ":buffer-previous";

          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
        };
      };

      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "nixfmt";
            };
          }
        ];
      };

      themes = {
        caelus = let
          c = config.lib.stylix.colors.withHashtag;
        in {
          "ui.background" = {
            bg = c.base00;
          };
          "ui.text" = {
            fg = c.base05;
          };
          "ui.text.focus" = {
            fg = c.base07;
            modifiers = [ "bold" ];
          };
          "ui.cursor" = {
            fg = c.base00;
            bg = c.base09;
          };
          "ui.cursor.primary" = {
            fg = c.base00;
            bg = c.base09;
          };
          "ui.cursor.match" = {
            fg = c.base09;
            bg = c.base02;
          };
          "ui.selection" = {
            bg = c.base02;
          };
          "ui.selection.primary" = {
            bg = c.base03;
          };
          "ui.cursorline.primary" = {
            bg = c.base01;
          };
          "ui.linenr" = {
            fg = c.base03;
          };
          "ui.linenr.selected" = {
            fg = c.base09;
            modifiers = [ "bold" ];
          };
          "ui.statusline" = {
            fg = c.base05;
            bg = c.base01;
          };
          "ui.statusline.inactive" = {
            fg = c.base04;
            bg = c.base00;
          };
          "ui.statusline.normal" = {
            fg = c.base00;
            bg = c.base09;
            modifiers = [ "bold" ];
          };
          "ui.statusline.insert" = {
            fg = c.base00;
            bg = c.base0C;
            modifiers = [ "bold" ];
          };
          "ui.statusline.select" = {
            fg = c.base00;
            bg = c.base0D;
            modifiers = [ "bold" ];
          };
          "ui.bufferline" = {
            fg = c.base04;
            bg = c.base00;
          };
          "ui.bufferline.active" = {
            fg = c.base09;
            bg = c.base01;
            modifiers = [ "bold" ];
          };
          "ui.bufferline.background" = {
            bg = c.base00;
          };
          "ui.popup" = {
            fg = c.base05;
            bg = c.base01;
          };
          "ui.window" = {
            fg = c.base02;
          };
          "ui.help" = {
            fg = c.base05;
            bg = c.base01;
          };

          "variable" = c.base05;
          "constant" = c.base09;
          "constant.numeric" = c.base09;
          "type" = c.base0C;
          "constructor" = c.base0C;
          "function" = c.base0D;
          "keyword" = c.base0A;
          "operator" = c.base0C;
          "string" = c.base0B;
          "comment" = {
            fg = c.base04;
            modifiers = [ "italic" ];
          };
          "diagnostic.error" = {
            fg = c.base08;
          };
          "diagnostic.warning" = {
            fg = c.base09;
          };
          "diagnostic.info" = {
            fg = c.base0D;
          };
          "diagnostic.hint" = {
            fg = c.base0C;
          };
        };
      };
    };
  };
}
