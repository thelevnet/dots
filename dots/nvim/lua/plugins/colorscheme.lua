return {
  {
    "RRethy/base16-nvim",
    lazy = false,
    priority = 1000,
  },

  -- Configure LazyVim to use Noctalia / base16
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local cache_path = vim.fn.expand("~/.cache/noctalia")
        if not string.find(package.path, cache_path, 1, true) then
          package.path = package.path .. ";" .. cache_path .. "/?.lua"
        end
        local ok, matugen = pcall(require, "matugen")
        if ok and matugen.setup then
          matugen.setup()
        end
      end,
    },
  },
}
