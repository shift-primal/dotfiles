return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function() require('conform').format { async = true, lsp_format = 'fallback' } end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      local ignore_filetypes =
        { dashboard = true, help = true, qf = true, netrw = true, fugitive = true, NvimTree = true, lazy = true, mason = true, TelescopePrompt = true }
      local bt = vim.bo[bufnr].buftype
      if bt ~= '' or ignore_filetypes[vim.bo[bufnr].filetype] then
        return nil
      elseif disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      ['*'] = { 'trim_whitespace' },
      lua = { 'stylua' },
      python = { 'black' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
