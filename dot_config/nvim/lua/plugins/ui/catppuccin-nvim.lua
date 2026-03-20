return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      default_integrations = true,
      auto_integrations = true,
      float = { transparent = true, solid = false },
    })
    vim.cmd([[colorscheme catppuccin-nvim]])
  end,
}
