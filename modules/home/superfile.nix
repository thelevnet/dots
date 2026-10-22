{ config, lib, ... }:

let
  c = config.lib.stylix.colors.withHashtag;
in
{
  options.modules.superfile = {
    enable = lib.mkEnableOption "Superfile TUI file manager";
  };

  config = lib.mkIf config.modules.superfile.enable {
    programs.superfile = {
      enable = true;

      settings = {
        theme = "caelus";
        auto_check_update = false;
        nerdfont = true;
        transparent_background = false;
        show_image_preview = true;
        default_open_file_preview = true;
        show_panel_footer_info = true;
        sidebar_width = 20;

        # Square borders
        border_top = "─";
        border_bottom = "─";
        border_left = "│";
        border_right = "│";
        border_top_left = "┌";
        border_top_right = "┐";
        border_bottom_left = "└";
        border_bottom_right = "┘";
        border_middle_left = "├";
        border_middle_right = "┤";
      };

      themes.caelus = {
        code_syntax_highlight = "monokai";

        # Border
        file_panel_border = c.base03;
        sidebar_border = c.base03;
        footer_border = c.base03;

        # Border active
        file_panel_border_active = c.base09;
        sidebar_border_active = c.base09;
        footer_border_active = c.base09;
        modal_border_active = c.base09;

        # Background
        full_screen_bg = c.base00;
        file_panel_bg = c.base00;
        sidebar_bg = c.base00;
        footer_bg = c.base00;
        modal_bg = c.base00;

        # Foreground
        full_screen_fg = c.base05;
        file_panel_fg = c.base05;
        sidebar_fg = c.base05;
        footer_fg = c.base05;
        modal_fg = c.base05;

        # Special
        cursor = c.base09;
        correct = c.base0B;
        error = c.base08;
        hint = c.base0C;
        cancel = c.base08;
        # No gradient: both stops identical
        gradient_color = [ c.base09 c.base09 ];

        # File panel
        file_panel_top_directory_icon = c.base09;
        file_panel_top_path = c.base0C;
        file_panel_item_selected_fg = c.base00;
        file_panel_item_selected_bg = c.base09;

        # Sidebar
        sidebar_title = c.base09;
        sidebar_item_selected_fg = c.base00;
        sidebar_item_selected_bg = c.base09;
        sidebar_divider = c.base03;

        # Modal
        modal_cancel_fg = c.base00;
        modal_cancel_bg = c.base08;
        modal_confirm_fg = c.base00;
        modal_confirm_bg = c.base0C;

        # Help menu
        help_menu_hotkey = c.base09;
        help_menu_title = c.base0C;
      };
    };

    # Footer visibility is runtime state (toggled with F), so seed it as hidden
    # only when missing/empty instead of symlinking a read-only file.
    home.activation.superfileHideFooter = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      state="${config.xdg.dataHome}/superfile/toggleFooter"
      if [ ! -s "$state" ]; then
        mkdir -p "$(dirname "$state")"
        printf 'false' > "$state"
      fi
    '';
  };
}
