require "nvchad.options"

local o = vim.o
local opt = vim.opt
local g = vim.g

-- Start

o.cursorlineopt = "both"

g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

opt.foldlevel = 99
opt.list = true
opt.relativenumber = true
opt.spelllang = { "en", "no" }
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
