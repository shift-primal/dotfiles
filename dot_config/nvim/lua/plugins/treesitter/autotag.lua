-- nvim-ts-autotag — auto-closes and auto-renames HTML/JSX/TSX tags using treesitter
-- Works in: html, xml, jsx, tsx, vue, svelte, php, markdown, and more
return {
  "windwp/nvim-ts-autotag",
  opts = {
    -- opts = {
    --   enable_close         = true,   -- auto close tags
    --   enable_rename        = true,   -- rename paired tag when you rename one
    --   enable_close_on_slash = false, -- close when typing </
    -- },
    -- per_filetype = {
    --   ["html"] = { enable_close = false },  -- disable auto-close for html specifically
    -- },
  },
}
