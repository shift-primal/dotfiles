vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.markdown_recommended_style = 0

local opt = vim.opt

-- Editing

opt.expandtab = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 0
opt.shiftround = true
opt.smartindent = true

-- Wrapping

opt.wrap = false
opt.linebreak = true

-- Appearance

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.termguicolors = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.showmode = false
opt.ruler = false
opt.laststatus = 3
opt.pumblend = 10
opt.pumheight = 10
opt.conceallevel = 2
opt.list = true
opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
opt.smoothscroll = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Search

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'
opt.grepprg = 'rg --vimgrep'
opt.grepformat = '%f:%l:%c:%m'

-- Splits

opt.splitright = true
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.winminwidth = 5

-- Folds

opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99
opt.foldtext = ''

-- Completion

opt.completeopt = 'menu,menuone,noselect,popup'

-- Behaviour

opt.autowrite = true
opt.confirm = true
opt.mouse = 'a'
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.timeoutlen = 300
opt.jumpoptions = 'view'
opt.virtualedit = 'block'
opt.wildmode = "longest:full,full"
opt.spelllang = { 'en' }
opt.sessionoptions = {
	'buffers',
	'curdir',
	'tabpages',
	'winsize',
	'help',
	'globals',
	'folds',
}
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Clipboard

opt.clipboard = vim.env.SSH_CONNECTION and '' or 'unnamedplus'

-- Custom filetypes

vim.filetype.add({
	extension = { todo = 'markdown', mdx = 'markdown' },
})
