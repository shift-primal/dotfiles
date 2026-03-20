return {
  "saghen/blink.cmp",
  opts = {
    cmdline = {
      enabled = true,
      keymap = {
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
      },
    },
  },
}
