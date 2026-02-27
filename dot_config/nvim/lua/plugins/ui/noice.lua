return {
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },

  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      background_colour = "#1e1e2e",
      timeout = 3000,
      render = "compact",
    },
    config = function(_, opts)
      local notify = require "notify"
      notify.setup(opts)
      vim.notify = notify
    end,
  },

  {
    "folke/noice.nvim",
    event = "UIEnter",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = false,
        },
        signature = { enabled = false },
      },
      presets = {
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      routes = {
        {
          filter = { event = "msg_show", kind = "", find = "written" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", kind = "search_count" },
          opts = { skip = true },
        },
      },
    },
  },
}
