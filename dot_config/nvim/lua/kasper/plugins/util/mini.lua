return { -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    require('mini.pairs').setup()
    require('mini.move').setup()
    require('mini.cursorword').setup()
  end,
}
