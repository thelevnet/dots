{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      format = lib.concatStrings [
        "[](green)[ ](fg:white bg:green)[ ](fg:green bg:black)$directory[](black)"
        "$fill"
        "[](black)$username$hostname"
        "[](fg:green bg:black)[ ](fg:white bg:green)[](green)\n"
      ];

      fill = {
        symbol = " ";
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
        format = "[ $user]($style)" ;
      };

      hostname = {
        ssh_only = false;
        style = "fg:white bg:black";
        format = "[@$hostname ]($style)";
      };

      character = {
        success_symbol = "[](green) ";
        error_symbol = "[](green) ";
      };
    };
  };

  # Transient prompt: collapses executed line down to  on Enter
  programs.zsh.initContent = lib.mkAfter ''
    autoload -Uz add-zsh-hook

    _starship_precmd() {
      PROMPT='$(starship prompt --terminal-width="$COLUMNS" --keymap="''${KEYMAP:-}" --status="''${STARSHIP_CMD_STATUS:-}" --pipestatus="''${STARSHIP_PIPE_STATUS[*]:-}" --cmd-duration="''${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
      RPROMPT=""
    }
    add-zsh-hook precmd _starship_precmd

    _starship_accept_line() {
      PROMPT=$'%{\e[32m%} %{\e[0m%}'
      RPROMPT=""
      zle reset-prompt
      zle .accept-line
    }
    zle -N accept-line _starship_accept_line

    preexec() {
      PROMPT=$'%{\e[32m%} %{\e[0m%}'
      RPROMPT=""
    }
  '';
}
