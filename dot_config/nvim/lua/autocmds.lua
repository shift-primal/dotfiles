require "nvchad.autocmds"

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})
