-- gitsigns.nvim — shows git hunk indicators in the sign column + inline blame
-- LazyVim binds: ]h/[h next/prev hunk, <leader>ghs stage, <leader>ghr reset,
--                <leader>ghp preview, <leader>ghb blame line, <leader>ghd diff
return {
  "lewis6991/gitsigns.nvim",
  opts = {
    -- Change the sign column characters:
    -- signs = {
    --   add          = { text = "│" },
    --   change       = { text = "│" },
    --   delete       = { text = "_" },
    --   topdelete    = { text = "‾" },
    --   changedelete = { text = "~" },
    --   untracked    = { text = "┆" },
    -- },
    -- current_line_blame = false,   -- inline git blame on current line
    -- current_line_blame_opts = {
    --   delay = 300,
    --   virt_text_pos = "eol",
    -- },
    -- word_diff = false,             -- show word-level diffs
    -- numhl = false,                 -- highlight line numbers for changed lines
  },
}
