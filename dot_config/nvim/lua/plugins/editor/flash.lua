-- flash.nvim — jump anywhere on screen by typing a label; also has treesitter-aware selection
-- LazyVim binds: s (jump), S (treesitter jump), r (remote flash in operator mode)
-- <c-space> does incremental treesitter selection expanding
return {
  "folke/flash.nvim",
  opts = {
    -- modes = {
    --   search = {
    --     enabled = false,  -- disable flash labels during / search
    --   },
    --   char = {
    --     enabled = false,  -- disable for f/t/F/T motions
    --   },
    -- },
    -- highlight = {
    --   backdrop = true,      -- dim everything except the flash labels
    --   matches = true,       -- highlight all matches
    -- },
    -- label = {
    --   uppercase = false,    -- use lowercase labels only
    --   rainbow = { enabled = false, shade = 5 },
    -- },
  },
}
