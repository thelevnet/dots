return {
  {
    "sainnhe/everforest",
    name = "everforest",
    lazy = false,
    priority = 1000,
    config = function()
      -- You can change the background contrast here: "hard", "medium", or "soft"
      vim.g.everforest_background = "soft"
      -- Enables italic text for keywords
      vim.g.everforest_enable_italic = 1
    end,
  },

  -- Tell LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
