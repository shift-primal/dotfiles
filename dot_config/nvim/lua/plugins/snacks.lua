return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  keys = {
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
  },

  opts = {
    scratch = {
      ft = "markdown",
      file_root = { cwd = false, branch = false }, -- Store in one place, not per-project
      win = {
        on_open = function(win)
          -- Disable autoformat (stops csharpier from running)
          vim.b[win.buf].autoformat = false
          -- Disable diagnostics
          vim.diagnostic.enable(false, { bufnr = win.buf })
          -- Detach all LSP clients from this buffer
          for _, client in pairs(vim.lsp.get_clients({ bufnr = win.buf })) do
            vim.lsp.buf_detach_client(win.buf, client.id)
          end
        end,
      },
    },
  },
}
