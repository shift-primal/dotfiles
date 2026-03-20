return {
  "folke/snacks.nvim",
  opts = {},
  keys = {
    {
      "<leader>ø",
      function()
        Snacks.scratch({ ft = "markdown" })
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
  },
}
