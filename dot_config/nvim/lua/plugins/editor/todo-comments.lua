-- todo-comments.nvim — highlights TODO, HACK, BUG, NOTE, FIX etc. and lists them
-- LazyVim binds: ]t/[t jump between TODOs, <leader>xt trouble list, <leader>st telescope
return {
  "folke/todo-comments.nvim",
  opts = {
    -- signs = true,    -- show icons in sign column
    -- keywords = {
    --   FIX  = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
    --   TODO = { icon = " ", color = "info" },
    --   HACK = { icon = " ", color = "warning" },
    --   WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    --   PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    --   NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    -- },
  },
}
