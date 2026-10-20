{ config, lib, ... }:

{
  options.modules.fastfetch = {
    enable = lib.mkEnableOption "Fastfetch CLI system info";
  };

  config = lib.mkIf config.modules.fastfetch.enable {
    programs.fastfetch = {
      enable = true;

      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = {
          source = "${config.xdg.configHome}/fastfetch/ascii.txt";
          type = "auto";
          color = {
            "1" = "33";
            "2" = "33";
          };
        };
        display = {
          separator = " ";
          color = {
            separator = "33";
            title = "33";
          };
        };
        modules = [
          { key = "╭────╮"; keyColor = "33"; type = "custom"; }
          { key = "│   │"; keyColor = "33"; type = "title"; format = "{user-name}@{host-name}"; }
          { key = "│   │"; keyColor = "33"; type = "os"; format = "{name}"; }
          { key = "│   │"; keyColor = "33"; type = "shell"; format = "{1}"; }
          { key = "│ 󰏓  │"; keyColor = "33"; type = "packages"; format = "{all}"; }
          { key = "│   │"; keyColor = "33"; type = "terminal"; format = "{1}"; }
          { key = "│   │"; keyColor = "33"; type = "wm"; format = "{1}"; }
          { key = "│ 󰝚  │"; keyColor = "33"; type = "media"; format = "{artist} - {title}"; }
          { key = "╰────╯"; keyColor = "33"; type = "custom"; }
        ];
      };
    };

    # Fastfetch custom ASCII art
    xdg.configFile."fastfetch/ascii.txt".text = ''
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⡤⠤⢤⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⡤⣺⣽⣾⣾⣔⣒⣷⡡⠱⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣠⣾⣾⢯⣞⣣⢟⣹⣿⣿⣷⢋⡔⢋⠂⡄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣴⣟⡶⣏⡿⣔⢫⣾⣿⣿⣿⣿⣷⣷⡉⠜⠃⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣰⡿⡞⡙⢾⢻⣌⣻⣿⣿⣿⠟⢉⢹⣷⡿⣹⠉⠓⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢠⣤⠿⡽⢛⡧⡶⣦⣉⢹⣿⣽⣿⡄⠈⣟⡉⠚⠁⠙⠀⠀⠀⠀⠀⠀⠀⠀
⠠⣴⡿⢷⠟⠍⠩⠞⢧⣭⡻⢦⡿⣿⣿⣷⣄⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠸⢟⣡⠢⢌⠂⢇⣭⢂⢹⡿⣧⣟⢶⢭⠿⣿⣷⣤⣀⡀⠀⠀⠀⣀⣤⣤⣤⣠⡄
⠈⢶⢭⣗⣮⢻⣭⢮⢯⣳⣳⣽⣻⣟⢿⢿⣴⣯⢿⣹⣟⢿⡻⣟⠿⣭⣯⡟⠞⠀
⠀⠀⠉⠙⠛⠛⠚⠛⠛⠓⠛⠓⠛⠛⠛⠛⠛⠓⠛⠛⠛⠛⠋⠉⠉⠉⠀⠀⠀⠀
'';
  };
}
