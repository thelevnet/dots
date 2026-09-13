{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.modules.starship = {
    enable = lib.mkEnableOption "Starship prompt";
  };

  config = lib.mkIf config.modules.starship.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        add_newline = false;

        format = lib.concatStrings [
          "[](green)[ ](fg:black bg:green)[ ](fg:green bg:black)$directory[ ](black)"
          "$fill"
          "[ ](black)$username$hostname"
          "[](fg:green bg:black)[ ](fg:black bg:green)[](green)\n"
          "$character"
        ];

        fill = {
          symbol = "·";
        };

        directory = {
          style = "fg:white bg:black";
          format = "[$path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          truncate_to_repo = false;
        };

        username = {
          show_always = true;
          style_user = "fg:white bg:black";
          format = "[ $user]($style)";
        };

        hostname = {
          ssh_only = false;
          style = "fg:white bg:black";
          format = "[@$hostname ]($style)";
        };

        character = {
          format = "[](green) ";
        };
      };
    };

    programs.zsh.initContent = lib.mkAfter ''
      _starship_full_prompt="$PROMPT"

      _starship_precmd() {
        PROMPT="$_starship_full_prompt"
      }
      add-zsh-hook precmd _starship_precmd

      _starship_accept_line() {
        PROMPT="$(starship module character)"
        zle reset-prompt
        zle .accept-line
      }
      zle -N accept-line _starship_accept_line
    '';
  };
}
