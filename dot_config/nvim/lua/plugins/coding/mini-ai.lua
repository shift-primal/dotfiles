-- mini.ai — extends a/i text objects; adds function, class, block, tag, digit, and more
-- LazyVim adds treesitter-powered: if/af (function), ic/ac (class), io/ao (block), it/at (tag)
-- Also: id (digits), ie (word with case), ig (whole buffer), iu/au (function call)
return {
  "nvim-mini/mini.ai",
  opts = {
    -- n_lines = 500,   -- how far to look for text object boundaries
    -- Add your own custom text objects:
    -- custom_textobjects = {
    --   -- Example: select between pipe characters |like this|
    --   ["|"] = { "|.-|", "^|().*()$" },
    -- },
  },
}
