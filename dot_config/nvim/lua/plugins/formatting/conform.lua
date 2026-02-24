return {

  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
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
  },
}
