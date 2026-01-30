return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cs = { "csharpier", "injected" },
      sql = { "sqlfluff" },
    },
    formatters = {
      sqlfluff = {
        command = "sqlfluff",
        args = { "format", "--dialect=sqlite", "--config", vim.fn.expand("~/.sqlfluff"), "-" },
        stdin = true,
        cwd = function()
          return vim.fn.getcwd()
        end,
      },
      prettier = {
        prepend_args = { "--trailing-comma", "none" },
      },
      injected = {
        options = {
          ignore_errors = true,
          lang_to_formatters = {
            sql = { "sqlfluff" },
          },
        },
      },
    },
  },
}
