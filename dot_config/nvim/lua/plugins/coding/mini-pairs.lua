-- mini.pairs — auto-inserts matching closing bracket/quote when you type an opener
-- Smart: skips closing when next char is word/quote, skips inside treesitter strings
return {
  "nvim-mini/mini.pairs",
  opts = {
    modes = { insert = true, command = true, terminal = false },
    -- skip_next = [=[[%w%%%'%[%"%.%`%$]=],  -- don't pair when next char matches this
    -- skip_ts = { "string" },               -- don't pair inside these treesitter nodes
    -- skip_unbalanced = true,               -- don't pair when more closing than opening
    -- markdown = true,                      -- smarter pairing in markdown code blocks
  },
}
