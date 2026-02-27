local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    cs = { "csharpier" },
    sql = { "sqlfluff" },
    toml = { "tombi" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
  },

  formatters = {
    prettier = {
      prepend_args = { "--trailing-comma", "none", "--tab-width", "2" },
    },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
