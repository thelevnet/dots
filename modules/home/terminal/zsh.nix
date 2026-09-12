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

        eval "$(zoxide init zsh)"
      '')
    ];
  };
}
