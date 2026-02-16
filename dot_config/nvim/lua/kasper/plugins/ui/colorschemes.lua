return {
  'catppuccin/nvim',
  opts = {
    custom_highlights = function(colors)
      return {
        NormalNC = { bg = colors.none },
        Normal = { bg = colors.none },
      }
    end,
  },
  name = 'catppuccin',
  priority = 1000,
}
