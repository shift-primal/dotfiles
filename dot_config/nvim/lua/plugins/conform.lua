return {

  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cs = { "csharpier" },
      sql = { "sqlfluff" },
      toml = { "tombi" },
      fish = {},
      ["*"] = { "injected" },
    },
    formatters = {
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
