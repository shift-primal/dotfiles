return {
  -- Add the rose-pine theme plugin
  {
    "rose-pine/neovim", -- Plugin repo URL
    as = "rose-pine", -- Optional alias for the plugin
    config = function()
      -- Customize theme if necessary
      require("rose-pine").setup({
        variant = "moon", -- You can use 'moon', 'dawn', or 'sun' here
        dark_variant = "moon", -- Use 'moon' for dark mode, 'dawn' or 'sun' are for lighter themes
      })
      -- Apply the colorscheme
      vim.cmd("colorscheme rose-pine")
    end,
    event = "VimEnter", -- Ensure it's loaded when Neovim starts
  },
}
