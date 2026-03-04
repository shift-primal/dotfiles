return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          win = {
            list = {
              wo = {
                winhighlight = "Normal:Normal,NormalNC:NormalNC,SignColumn:Normal",
              },
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>ø",
      function()
        Snacks.scratch({ ft = "markdown" })
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
}
