-- trouble.nvim — pretty diagnostics, references, quickfix and location list
-- LazyVim binds: <leader>xx diagnostics, <leader>xX buffer diagnostics,
--                <leader>cs symbols, <leader>cS LSP refs, <leader>xL loclist, <leader>xQ quickfix
return {
  "folke/trouble.nvim",
  opts = {
    -- focus = false,              -- auto focus the trouble window when opened
    -- auto_close = false,         -- auto close when no more items
    -- warn_no_results = true,

    modes = {
      -- Change position of the LSP panel
      lsp = {
        win = { position = "right" }, -- "bottom" | "right"
      },
    },
  },
}
