-- If Neovim was opened with a directory, cd into it
local arg = vim.fn.argv(0)
if arg and arg ~= '' then
  local path = vim.fn.fnamemodify(arg, ':p')
  if vim.fn.isdirectory(path) == 1 then
    vim.cmd.cd(path)
  else
    local dir = vim.fn.fnamemodify(path, ':h')
    local home = vim.env.HOME
    local root = vim.fs.root(path, { '.git', 'Makefile', 'package.json', 'Cargo.toml' })
    if not root then
      root = path:match('^(' .. home .. '/[^/]+/[^/]+)/')
    end
    if root then vim.cmd.cd(root) else vim.cmd.cd(dir) end
  end
end

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
