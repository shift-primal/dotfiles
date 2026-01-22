-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Workaround for Neovim signcols crash (https://github.com/neovim/neovim/issues/33067)
vim.opt.statuscolumn = ""

vim.opt.textwidth = 240
vim.opt.formatoptions:append("t")

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
