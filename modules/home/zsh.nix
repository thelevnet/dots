{
  config,
  lib,
  pkgs,
  ...
}:

let
  c = config.lib.stylix.colors.withHashtag;
  existing = "fg=${c.base09},bold";

  # Zsh's ZLE region_highlight does not have a dedicated "strikethrough" attribute
  # keyword in 5.9, so we compile a Zsh-only terminfo where smso/rmso ("standout")
  # emit ANSI strikethrough (\e[9m / \e[29m). Zsh loads this into its internal
  # termcap table at startup and immediately restores TERMINFO for child processes.
  strikethroughTerminfo =
    pkgs.runCommand "zsh-strikethrough-terminfo"
      {
        nativeBuildInputs = [ pkgs.ncurses ];
      }
      ''
        mkdir -p "$out"
        export TERMINFO_DIRS="${pkgs.kitty.terminfo}/share/terminfo:${pkgs.ncurses}/share/terminfo"
        for term in xterm-kitty xterm-256color xterm tmux-256color; do
          infocmp -x "$term" \
            | sed 's/smso=\\E\[[0-9;]*m/smso=\\E[9m/g; s/rmso=\\E\[[0-9;]*m/rmso=\\E[29m/g' \
            > "$term.src"
          tic -x -o "$out" "$term.src" 2>/dev/null
        done
      '';
in
{
  options.modules.zsh = {
    enable = lib.mkEnableOption "Zsh shell configuration";
  };

  config = lib.mkIf config.modules.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        styles = {
          # command exists -> bold orange
          command = existing;
          builtin = existing;
          alias = existing;
          function = existing;
          precommand = existing;
          hashed-command = existing;
          suffix-alias = existing;
          global-alias = existing;
          # could still become a command (custom "prefix" highlighter) -> white underlined
          prefix-token = "fg=${c.base05},underline";
          # can never be a command -> white crossed out (strikethrough via ZLE standout)
          unknown-token = "fg=${c.base05},standout";
        };
      };

      shellAliases = {
        l = "eza --icons --group-directories-first";
        la = "eza -a --icons --group-directories-first";
        lt = "eza --tree --level=4";
      };

      initContent = lib.mkMerge [
        (lib.mkBefore ''
          zsh-newuser-install() { :; }
          if [[ "$TERMINFO" != "${strikethroughTerminfo}" && -z "$_ZSH_TI_LOADED" ]]; then
            export _ZSH_TI_LOADED=1
            _zsh_flags=(-i)
            [[ -o login ]] && _zsh_flags+=(-l)
            _ZSH_ORIG_TERMINFO="$TERMINFO" TERMINFO="${strikethroughTerminfo}" exec -a "$0" "$ZSH_ARGZERO" "''${_zsh_flags[@]}"
          fi
          unset _ZSH_TI_LOADED _zsh_flags
          if [[ -n "$_ZSH_ORIG_TERMINFO" ]]; then
            export TERMINFO="$_ZSH_ORIG_TERMINFO"
            unset _ZSH_ORIG_TERMINFO
          else
            unset TERMINFO
          fi
          PROMPT_EOL_MARK='%B%F{0}%K{7}%#%k%f%b'
          zle_highlight=(region:bg=${c.base02},fg=${c.base05} special:fg=${c.base09},bold suffix:bold isearch:underline)
        '')
        (lib.mkOrder 600 ''
          _zsh_highlight_highlighter_prefix_predicate() {
            _zsh_highlight_buffer_modified
          }

          _zsh_highlight_highlighter_prefix_paint() {
            emulate -L zsh
            setopt extendedglob

            local -a tokens hits
            local rest=$BUFFER tok kind
            local -i off=0 idx start expect=1

            tokens=( ''${(z)BUFFER} )

            for tok in $tokens; do
              idx=''${rest[(ie)$tok]}
              (( idx > ''${#rest} )) && break
              start=$(( off + idx - 1 ))
              rest=''${rest[idx+''${#tok},-1]}
              off=$(( start + ''${#tok} ))

              case $tok in
                ';'|'|'|'&'|'&&'|'||'|'|&'|'('|'{'|'&!'|'&|')
                  expect=1
                  continue
                  ;;
              esac

              (( expect )) || continue

              [[ $tok == [A-Za-z_][A-Za-z0-9_]#=* ]] && continue

              expect=0

              [[ $tok == [A-Za-z0-9_.+-]## ]] || continue

              kind=$(whence -w -- $tok 2>/dev/null)
              kind=''${kind#*: }
              [[ -n $kind && $kind != none ]] && continue

              hits=(
                ''${(M)''${(k)commands}:#''${(b)tok}*}
                ''${(M)''${(k)aliases}:#''${(b)tok}*}
                ''${(M)''${(k)functions}:#''${(b)tok}*}
                ''${(M)''${(k)builtins}:#''${(b)tok}*}
                ''${(M)''${(k)reswords}:#''${(b)tok}*}
              )
              if (( ''${#hits} )); then
                _zsh_highlight_add_highlight $start $off prefix-token
              fi
            done
          }
        '')
        (lib.mkAfter ''
          ZSH_HIGHLIGHT_HIGHLIGHTERS=(main prefix)
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
