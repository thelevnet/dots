{ config, pkgs, lib, ... }:

{
  options.modules.hex = {
    enable = lib.mkEnableOption "Raw shellcode binfmt registration";
  };

  config = lib.mkIf config.modules.hex.enable {
    boot.binfmt.registrations."raw-shellcode" = {
      recognitionType = "extension";
      magicOrExtension = "raw";
      interpreter = "${pkgs.runraw}/bin/runraw";
      wrapInterpreterInShell = false;
    };
  };
}
