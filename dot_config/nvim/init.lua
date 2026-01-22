-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_user_command("TrimWhitespace", [[%s/\s\+$//e]], {})
vim.opt.statuscolumn = ""
