-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      asm_lsp = {
        -- asm_lsp supports NASM, GAS, and GO assembly out of the box
        filetypes = { "asm", "vmasm", "nasm" },
      },
    },
  },
}
