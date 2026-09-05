return {
  {
    "RRethy/base16-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local cache_path = vim.fn.expand("~/.cache/noctalia")
      package.path = package.path .. ";" .. cache_path .. "/?.lua"

      local function apply_theme()
        local ok, matugen = pcall(require, "matugen")
        if ok and matugen.setup then
          matugen.setup()
        end
      end

      apply_theme()
    end,
  },
}
