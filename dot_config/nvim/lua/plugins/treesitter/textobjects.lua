-- nvim-treesitter-textobjects — jump to and select functions, classes, parameters
-- LazyVim binds: ]f/[f next/prev function, ]c/[c class, ]a/[a parameter
--                (capital letter = end of node, lowercase = start)
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  opts = {
    move = {
      enable = true,
      set_jumps = true,
      keys = {
        goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
        goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
        goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        -- Add more:
        -- goto_next_start = { ["]m"] = "@call.outer" },
      },
    },
  },
}
