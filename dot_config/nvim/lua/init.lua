-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_user_command("TrimWhitespace", [[%s/\s\+$//e]], {})
vim.opt.statuscolumn = ""

vim.keymap.set({ "i", "v", "c", "o", "t" }, "<F13>", "<Esc>")

vim.api.nvim_set_hl(0, "@lsp.type.stringVerbatim.cs", {})

require("arrow-trainer").setup({
  start_disabled = true,
  toggle_key = "<leader>ak",
})
