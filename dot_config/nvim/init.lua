require 'kasper.opts'
require 'kasper.autocmds'
require 'kasper.keymaps'
require 'kasper.lazy'

local plugins = {
  { import = 'kasper.plugins.code' },
  { import = 'kasper.plugins.ui' },
  { import = 'kasper.plugins.util' },
}

local opts = {}

require('lazy').setup {
  plugins,
  opts,
}

vim.cmd.colorscheme 'catppuccin-mocha'
