{ config, pkgs, inputs, lib, ... }:

let
  # Pure declarative LazyVim plugins from nixpkgs
  lazyPlugins = with pkgs.vimPlugins; [
    # Core LazyVim
    LazyVim
    lazy-nvim

    # UI & Appearance
    bufferline-nvim
    lualine-nvim
    noice-nvim
    nui-nvim
    snacks-nvim
    which-key-nvim
    tokyonight-nvim
    base16-nvim

    # Mini plugins
    { name = "mini.ai"; path = mini-nvim; }
    { name = "mini.icons"; path = mini-nvim; }
    { name = "mini.pairs"; path = mini-nvim; }
    { name = "catppuccin"; path = catppuccin-nvim; }

    # Coding & Completion
    blink-cmp
    friendly-snippets
    ts-comments-nvim
    lazydev-nvim
    luvit-meta

    # Editor & Navigation
    flash-nvim
    grug-far-nvim
    persistence-nvim
    plenary-nvim
    todo-comments-nvim
    trouble-nvim
    telescope-nvim
    telescope-fzf-native-nvim
    indent-blankline-nvim
    dashboard-nvim
    dressing-nvim
    neo-tree-nvim

    # LSP & Linting
    nvim-lspconfig
    nvim-lint

    # Treesitter (with all pre-compiled grammars)
    nvim-treesitter.withAllGrammars
    nvim-treesitter-textobjects
    nvim-ts-autotag
  ];

  mkEntryFromDrv = drv:
    if lib.isDerivation drv then
      { name = "${lib.getName drv}"; path = drv; }
    else
      drv;

  lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv lazyPlugins);
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  options.modules.neovim = {
    enable = lib.mkEnableOption "Neovim editor with pure-Nix LazyVim";
  };

  config = lib.mkIf config.modules.neovim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      nixpkgs.useGlobalPackages = true;

      # Only Rust LSP and editor CLI utilities (no git, no extra LSPs, no formatters)
      extraPackages = with pkgs; [
        rust-analyzer
        ripgrep
        fd
        gcc
        gnumake
        kitty
      ];

      # Only lazy-nvim and base16-nvim are loaded into initial runtimepath
      extraPlugins = with pkgs.vimPlugins; [
        lazy-nvim
        base16-nvim
      ];

      opts = {
        number = true;
        relativenumber = false;
        # Disable all code folding (show the entire code at all times)
        foldenable = false;
        foldlevel = 99;
        foldlevelstart = 99;
        foldcolumn = "0";
        statuscolumn = "";
        clipboard = "unnamedplus";
        expandtab = true;
        shiftwidth = 2;
        tabstop = 2;
        smartindent = true;
        shiftround = true;
        ignorecase = true;
        smartcase = true;
        incsearch = true;
        hlsearch = true;
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
        undofile = true;
        swapfile = false;
        updatetime = 200;
        timeoutlen = 300;
        mouse = "a";
        confirm = true;
        fillchars = {
          eob = " ";
          fold = " ";
          foldopen = " ";
          foldclose = " ";
          foldsep = " ";
        };
      };

      globals = {
        mapleader = " ";
        maplocalleader = "\\";
        # Disable autoformatting globally
        autoformat = false;
      };

      # Run before LazyVim loads: Matugen base16 colorscheme setup & Kitty padding
      extraConfigLuaPre = ''
        -- Ensure Noctalia Matugen Lua configuration can be loaded
        local cache_path = vim.fn.expand("~/.cache/noctalia")
        if not string.find(package.path, cache_path, 1, true) then
          package.path = package.path .. ";" .. cache_path .. "/?.lua"
        end
        local ok, matugen = pcall(require, "matugen")
        if ok and matugen.setup then
          matugen.setup()
        end

        -- Dynamically remove Kitty window padding inside Neovim, restore on exit/suspend
        vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
          callback = function()
            if vim.env.KITTY_WINDOW_ID and vim.fn.executable("kitty") == 1 then
              pcall(vim.system, { "kitty", "@", "set-spacing", "padding=0" })
            end
          end,
        })
        vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, {
          callback = function()
            if vim.env.KITTY_WINDOW_ID and vim.fn.executable("kitty") == 1 then
              pcall(function()
                vim.system({ "kitty", "@", "set-spacing", "padding=default" }):wait()
              end)
            end
          end,
        })
      '';

      # Declarative LazyVim initialization
      extraConfigLua = ''
        -- Configure project root detection (without git)
        vim.g.root_spec = { "lsp", { "flake.nix", "Cargo.toml", "package.json", "lua" }, "cwd" }

        require("lazy").setup({
          defaults = {
            lazy = true,
          },
          dev = {
            path = "${lazyPath}",
            patterns = { "" },
            fallback = false,
          },
          spec = {
            -- Import all standard LazyVim core plugins
            {
              "LazyVim/LazyVim",
              import = "lazyvim.plugins",
              opts = {
                colorscheme = function()
                  local cache_path = vim.fn.expand("~/.cache/noctalia")
                  if not string.find(package.path, cache_path, 1, true) then
                    package.path = package.path .. ";" .. cache_path .. "/?.lua"
                  end
                  local ok, matugen = pcall(require, "matugen")
                  if ok and matugen.setup then
                    matugen.setup()
                  else
                    vim.cmd.colorscheme("tokyonight")
                  end
                end,
                news = {
                  lazyvim = false,
                  neovim = false,
                },
              },
            },

            -- Enable telescope-fzf-native
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },

            -- Disable Mason (tools are declaratively installed via Nix extraPackages)
            { "williamboman/mason.nvim", enabled = false },
            { "williamboman/mason-lspconfig.nvim", enabled = false },

            -- Completely disable git signs / symbols
            { "lewis6991/gitsigns.nvim", enabled = false },

            -- Completely disable conform.nvim formatter
            { "stevearc/conform.nvim", enabled = false },

            -- Disable all git features in snacks (lazygit, gitbrowse, git status, git pickers)
            {
              "folke/snacks.nvim",
              opts = {
                statuscolumn = { enabled = false },
                git = { enabled = false },
                gitbrowse = { enabled = false },
                lazygit = { enabled = false },
                picker = {
                  sources = {
                    explorer = {
                      git_status = false,
                      git_untracked = false,
                    },
                  },
                },
              },
            },

            -- Hide git group from which-key menu
            {
              "folke/which-key.nvim",
              opts = {
                spec = {
                  { "<leader>g", hidden = true },
                  { "<leader>gh", hidden = true },
                },
              },
            },

            -- Treesitter: use Nix pre-compiled grammars
            {
              "nvim-treesitter/nvim-treesitter",
              opts = function(_, opts)
                opts.ensure_installed = {}
              end,
            },

            -- Blink.cmp completion with Super-Tab preset
            {
              "saghen/blink.cmp",
              opts = {
                keymap = {
                  preset = "super-tab",
                },
              },
            },

            -- Minimal Lualine keeping Noctalia rounded style and showing active filename
            {
              "nvim-lualine/lualine.nvim",
              opts = function(_, opts)
                opts.options = {
                  globalstatus = true,
                  theme = "auto",
                  section_separators = { left = "", right = "" },
                  component_separators = { left = "", right = "" },
                }
                opts.sections = {
                  lualine_a = { "mode" },
                  lualine_b = {},
                  lualine_c = {
                    {
                      "filename",
                      path = 1,
                    },
                  },
                  lualine_x = {},
                  lualine_y = {},
                  lualine_z = { "location" },
                }
              end,
            },

            -- ONLY Rust LSP (all other servers completely removed, folding disabled)
            {
              "neovim/nvim-lspconfig",
              opts = {
                folds = { enabled = false },
                servers = {
                  lua_ls = { enabled = false },
                  rust_analyzer = {},
                },
              },
            },
          },
        })

        -- Disable relative line numbers (use normal absolute line numbers)
        vim.opt.relativenumber = false

        -- Disable all code folding completely (show full code, never collapse)
        vim.opt.foldenable = false
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.opt.foldcolumn = "0"
        vim.opt.statuscolumn = ""

        -- Permanently disable all formatting on save and manual triggers
        vim.g.autoformat = false
        vim.api.nvim_create_autocmd("User", {
          pattern = "VeryLazy",
          callback = function()
            vim.g.autoformat = false
            if LazyVim and LazyVim.format then
              LazyVim.format.format = function() end
            end

            -- Purge all git keymaps from Neovim
            local git_keys = { "gg", "gG", "gL", "gb", "gf", "gl", "gB", "gY", "gd", "gD", "gs", "gS", "gi", "gI", "gp", "gP" }
            for _, k in ipairs(git_keys) do
              pcall(vim.keymap.del, "n", "<leader>" .. k)
              pcall(vim.keymap.del, "x", "<leader>" .. k)
            end
            pcall(vim.keymap.del, "n", "]h")
            pcall(vim.keymap.del, "n", "[h")
          end,
        })

        -- Ensure buffer windows never enable folding or fold statuscolumn
        vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
          callback = function()
            vim.opt_local.foldenable = false
            vim.opt_local.foldcolumn = "0"
            vim.opt_local.statuscolumn = ""
          end,
        })
      '';
    };
  };
}
