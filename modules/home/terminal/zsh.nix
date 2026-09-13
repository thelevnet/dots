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
        _text() {
          print -P "%{\e[32m%}%{\e[0m%}%{\e[42m\e[30m%}󰍪 %{\e[0m%}%{\e[32m%}%{\e[0m%} $1"
        }
        clear
        fastfetch
        _text "こんにちは、レフ！"
        echo
        unfunction _text

        eval "$(zoxide init zsh)"
      '')
    ];
  };
}
