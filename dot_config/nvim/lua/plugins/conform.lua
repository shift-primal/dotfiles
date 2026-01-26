return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cs = { "csharpier" },
    },
    formatters = {
      prettier = {
        prepend_args = { "--trailing-comma", "none" },
      },
    },
  },
}
