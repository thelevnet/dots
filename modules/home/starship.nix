{ config, lib, ... }:

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

        format = "$directory\n$character";


        directory = {
          style = "white";
          format = "[|](orange) [$path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          truncate_to_repo = false;
        };

        character = {
          format = "[\\\$](orange) ";
        };
      };
    };
    programs.zsh.initContent = lib.mkAfter ''
      autoload -Uz add-zsh-hook

      _starship_full_prompt="$PROMPT"
      _starship_full_rprompt="$RPROMPT"

      _starship_precmd() {
        PROMPT="$_starship_full_prompt"
        RPROMPT="$_starship_full_rprompt"
      }
      add-zsh-hook precmd _starship_precmd

      _starship_accept_line() {
        PROMPT="$(starship module character)"
        RPROMPT=""
        zle reset-prompt
        zle .accept-line
      }
      zle -N accept-line _starship_accept_line

      TRAPINT() {
        zle && {
          PROMPT="$(starship module character)"
          RPROMPT=""
          zle reset-prompt
        }
        return $(( 128 + $1 ))
      }
    '';
  };
}
