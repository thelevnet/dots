{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "colored-man-pages"
      ];
    };

    shellAliases = {
      ls = "eza --icons --group-directories-first";
      la = "eza -a --icons --group-directories-first";
      lt = "eza --tree --level=4";
      imperio = "sudo ";
    };

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        fpath=(/home/lev/.zsh/completions $fpath)
        zsh-newuser-install() { :; }
      '')
      (lib.mkAfter ''
        text() {
          print -P "%{\e[32m%}%{\e[0m%}%{\e[42m\e[37m%}SYS%{\e[0m%}%{\e[0m%}%{\e[32m%}%{\e[0m%} $1"
        }
        clear
        text "fastfetch"
        fastfetch
        text "こんにちは、レフ！"
        echo

        MY_TOP_PROMPT=$'%{\e[32m%}%{\e[0m%}%{\e[42m\e[37m%}󰉋 %~%{\e[0m%}%{\e[32m%}%{\e[0m%} %{\e[32m%} %{\e[0m%}'
        MY_RPROMPT=$'%{\e[32m%}%{\e[0m%}%{\e[42m\e[37m%}%D{%H:%M}%{\e[0m%}%{\e[32m%}%{\e[0m%} %{\e[32m%}%{\e[0m%}%{\e[42m\e[37m%} %{\e[0m%}%{\e[32m%}%{\e[0m%}'
        MY_BOTTOM_PROMPT=$'%{\e[32m%} %{\e[0m%}'

        PROMPT=$MY_TOP_PROMPT
        RPROMPT=$MY_RPROMPT

        _my_accept_line() {
          PROMPT=$MY_BOTTOM_PROMPT
          RPROMPT=""
          zle reset-prompt
          zle .accept-line
        }
        zle -N accept-line _my_accept_line

        preexec() {
          PROMPT=$MY_BOTTOM_PROMPT
          RPROMPT=""
        }

        precmd() {
          PROMPT=$MY_TOP_PROMPT
          RPROMPT=$MY_RPROMPT
        }

        refresh_prompt() {
          zle && zle reset-prompt
        }

        TMOUT=60
        TRAPALRM() {
          refresh_prompt
        }
      '')
    ];
  };
}
