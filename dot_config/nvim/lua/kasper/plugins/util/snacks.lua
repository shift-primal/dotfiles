return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      notifier = {},
      dashboard = {},
      explorer = {},
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
          files = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
    keys = {
      { '<leader>e', function() Snacks.explorer() end, desc = 'Toggle Explorer' },
      { '<leader>E', function() Snacks.explorer { cwd = vim.env.HOME } end, desc = 'Explorer (Home)' },
    },
  },
}
