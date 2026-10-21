{ config, lib, ... }:

{
  options.modules.zsh = {
    enable = lib.mkEnableOption "Zsh shell configuration";
  };

  config = lib.mkIf config.modules.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        l = "eza --icons --group-directories-first";
        la = "eza -a --icons --group-directories-first";
        lt = "eza --tree --level=4";
      };

      initContent = lib.mkMerge [
        (lib.mkBefore ''
          zsh-newuser-install() { :; }
        '')
        (lib.mkAfter ''
          compdef _next next 2>/dev/null || true
        '')
      ];
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
