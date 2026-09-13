{ config, pkgs, inputs, lib, ... }:

let
  tomlFormat = pkgs.formats.toml { };
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  options.modules.neovim = {
    enable = lib.mkEnableOption "Neovim editor with Nixvim";
  };

  config = lib.mkIf config.modules.neovim.enable {
    programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    nixpkgs.useGlobalPackages = true;

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    opts = {
      # Line numbers
      number = true;
      relativenumber = false;

      # Clipboard
      clipboard = "unnamedplus";

      # Indentation
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      shiftround = true;

      # Search
      ignorecase = true;
      smartcase = true;
      incsearch = true;
      hlsearch = true;

      # UI & Window behavior
      termguicolors = true;
      signcolumn = "yes";
      cursorline = true;
      scrolloff = 4;
      sidescrolloff = 8;
      wrap = false;
      splitbelow = true;
      splitright = true;
      pumheight = 10;
      conceallevel = 2;

      # Undo & Persistence
      undofile = true;
      undolevels = 10000;
      swapfile = false;
      updatetime = 200;
      timeoutlen = 300;
      mouse = "a";
      confirm = true;

      # Remove '~' squiggly lines past the end of the buffer
      fillchars = {
        eob = " ";
      };
    };

    plugins = {
      # Completion & Snippets
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "default";
          };
          appearance = {
            nerd_font_variant = "mono";
          };
          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
            ];
          };
        };
      };
      friendly-snippets.enable = true;

      # UI
      bufferline = {
        enable = true;
        settings = {
          options = {
            diagnostics = "nvim_lsp";
            always_show_bufferline = false;
            offsets = [
              {
                filetype = "snacks_layout_box";
                text = "File Explorer";
                text_align = "left";
              }
            ];
          };
        };
      };

      lualine = {
        enable = true;
        settings = {
          options = {
            globalstatus = true;
            theme = "auto";
            section_separators = {
              left = "";
              right = "";
            };
            component_separators = {
              left = "";
              right = "";
            };
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b.__raw = "{}";
            lualine_c.__raw = "{}";
            lualine_x.__raw = "{}";
            lualine_y.__raw = "{}";
            lualine_z = [ "location" ];
          };
        };
      };

      which-key.enable = true;

      noice = {
        enable = true;
        settings = {
          lsp = {
            override = {
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.set_lines_to_formatting" = true;
              "cmp.entry.get_documentation" = true;
            };
          };
          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
          };
        };
      };

      # Snacks (Explorer, Picker, Dashboard, etc.)
      snacks = {
        enable = true;
        settings = {
          bigfile.enabled = true;
          dashboard.enabled = true;
          explorer.enabled = true;
          indent = {
            enabled = true;
            hl = "LineNr";
          };
          input.enabled = true;
          notifier.enabled = true;
          picker.enabled = true;
          quickfile.enabled = true;
          scope = {
            enabled = true;
            hl = "Comment";
          };
          scroll.enabled = true;
          statuscolumn.enabled = true;
          words.enabled = true;
        };
      };

      # Navigation, Git & Tools
      flash.enable = true;
      gitsigns.enable = false;
      grug-far.enable = true;
      trouble.enable = true;
      todo-comments.enable = true;
      persistence.enable = true;
      lazydev.enable = true;
      ts-comments.enable = true;

      mini = {
        enable = true;
        modules = {
          ai = { };
          pairs = { };
          icons = { };
        };
      };

      # Treesitter syntax highlighting (includes slint)
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      treesitter-textobjects.enable = true;
      ts-autotag.enable = true;

      # Formatting (manual only, never auto-format on save)
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
          };
        };
      };

      lint.enable = true;

      # Language Server Protocol (LSP)
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
          };
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gr" = "references";
            "gI" = "implementation";
            "gy" = "type_definition";
            "K" = "hover";
            "gK" = "signature_help";
            "<leader>ca" = "code_action";
            "<leader>cr" = "rename";
          };
        };
        servers = {
          asm_lsp = {
            enable = true;
            filetypes = [
              "asm"
              "vmasm"
              "nasm"
            ];
          };
          lua_ls.enable = true;
          nil_ls.enable = true;
        };
      };
    };

    # Extra plugins (Base16 theme support)
    extraPlugins = with pkgs.vimPlugins; [
      base16-nvim
    ];

    # Extra runtime tools & packages
    extraPackages = with pkgs; [
      git
      gcc
      gnumake
      ripgrep
      fd
      stylua
      asm-lsp
      kitty
    ];

    # Keymaps matching LazyVim defaults
    keymaps = [
      # Window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Go to Left Window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Go to Lower Window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Go to Upper Window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Go to Right Window";
      }

      # Resize window
      {
        mode = "n";
        key = "<C-Up>";
        action = "<cmd>resize +2<cr>";
        options.desc = "Increase Window Height";
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<cmd>resize -2<cr>";
        options.desc = "Decrease Window Height";
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = "<cmd>vertical resize -2<cr>";
        options.desc = "Decrease Window Width";
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<cmd>vertical resize +2<cr>";
        options.desc = "Increase Window Width";
      }

      # Buffers
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>bprevious<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>bnext<cr>";
        options.desc = "Next Buffer";
      }
      {
        mode = "n";
        key = "[b";
        action = "<cmd>bprevious<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = "n";
        key = "]b";
        action = "<cmd>bnext<cr>";
        options.desc = "Next Buffer";
      }

      # Clear search with <esc>
      {
        mode = [
          "i"
          "n"
        ];
        key = "<esc>";
        action = "<cmd>noh<cr><esc>";
        options.desc = "Escape and Clear hlsearch";
      }

      # Better indenting
      {
        mode = "v";
        key = "<";
        action = "<gv";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
      }

      # Move lines
      {
        mode = "n";
        key = "<A-j>";
        action = "<cmd>execute 'move .+' . v:count1<cr>==";
        options.desc = "Move Down";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
        options.desc = "Move Up";
      }
      {
        mode = "i";
        key = "<A-j>";
        action = "<esc><cmd>m .+1<cr>==gi";
        options.desc = "Move Down";
      }
      {
        mode = "i";
        key = "<A-k>";
        action = "<esc><cmd>m .-2<cr>==gi";
        options.desc = "Move Up";
      }
      {
        mode = "v";
        key = "<A-j>";
        action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
        options.desc = "Move Down";
      }
      {
        mode = "v";
        key = "<A-k>";
        action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
        options.desc = "Move Up";
      }

      # Snacks Picker / Explorer
      {
        mode = "n";
        key = "<leader><space>";
        action = "<cmd>lua Snacks.picker.files()<cr>";
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>lua Snacks.picker.grep()<cr>";
        options.desc = "Grep";
      }
      {
        mode = "n";
        key = "<leader>,";
        action = "<cmd>lua Snacks.picker.buffers()<cr>";
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua Snacks.explorer()<cr>";
        options.desc = "File Explorer";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>lua Snacks.picker.files()<cr>";
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>sg";
        action = "<cmd>lua Snacks.picker.grep()<cr>";
        options.desc = "Grep";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>lua Snacks.bufdelete()<cr>";
        options.desc = "Delete Buffer";
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>lua Snacks.lazygit()<cr>";
        options.desc = "Lazygit";
      }

      # Trouble
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options.desc = "Buffer Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle focus=false<cr>";
        options.desc = "Symbols (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cl";
        action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
        options.desc = "LSP References (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        options.desc = "Location List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xQ";
        action = "<cmd>Trouble qflist toggle<cr>";
        options.desc = "Quickfix List (Trouble)";
      }

      # Flash
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options.desc = "Flash";
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "S";
        action = "<cmd>lua require('flash').treesitter()<cr>";
        options.desc = "Flash Treesitter";
      }

      # Persistence
      {
        mode = "n";
        key = "<leader>qs";
        action = "<cmd>lua require('persistence').load()<cr>";
        options.desc = "Restore Session";
      }
      {
        mode = "n";
        key = "<leader>ql";
        action = "<cmd>lua require('persistence').load({ last = true })<cr>";
        options.desc = "Restore Last Session";
      }
      {
        mode = "n";
        key = "<leader>qd";
        action = "<cmd>lua require('persistence').stop()<cr>";
        options.desc = "Don't Save Current Session";
      }

      # Formatting
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>cf";
        action = "<cmd>lua require('conform').format({ async = true, lsp_format = 'never' })<cr>";
        options.desc = "Format Document";
      }
    ];

    # Autocommands
    autoCmd = [
      {
        event = [ "TextYankPost" ];
        callback.__raw = "function() vim.highlight.on_yank() end";
      }

      # Dynamically remove Kitty window padding inside Neovim, restore on exit/suspend
      {
        event = [ "VimEnter" "VimResume" ];
        callback.__raw = ''
          function()
            if vim.env.KITTY_WINDOW_ID and vim.fn.executable("kitty") == 1 then
              pcall(vim.system, { "kitty", "@", "set-spacing", "padding=0" })
            end
          end
        '';
      }
      {
        event = [ "VimLeavePre" "VimSuspend" ];
        callback.__raw = ''
          function()
            if vim.env.KITTY_WINDOW_ID and vim.fn.executable("kitty") == 1 then
              pcall(function()
                vim.system({ "kitty", "@", "set-spacing", "padding=default" }):wait()
              end)
            end
          end
        '';
      }
    ];

    # Pure Nix compatibility: mock lazy.stats for plugins (e.g. snacks.dashboard)
    extraConfigLuaPre = ''
      local cache_path = vim.fn.expand("~/.cache/noctalia")
      if not string.find(package.path, cache_path, 1, true) then
        package.path = package.path .. ";" .. cache_path .. "/?.lua"
      end
      local ok, matugen = pcall(require, "matugen")
      if ok and matugen.setup then
        matugen.setup()
      end

      local _start_time = vim.fn.reltime()
      package.preload["lazy.stats"] = function()
        return {
          stats = function()
            local count = #vim.api.nvim_list_runtime_paths()
            return {
              count = count,
              loaded = count,
              startuptime = vim.fn.reltimefloat(vim.fn.reltime(_start_time)) * 1000,
            }
          end,
        }
      end
    '';

    # Noctalia / Matugen dynamic colorscheme loader
    extraConfigLua = ''
      local ok, matugen = pcall(require, "matugen")
      if ok and matugen.setup then
        matugen.setup()
      end
    '';
  };

  # Stylua configuration file
  xdg.configFile."nvim/stylua.toml".source = tomlFormat.generate "stylua.toml" {
    indent_type = "Spaces";
    indent_width = 2;
    column_width = 120;
  };
  };
}
