-- nvim-treesitter — AST-based syntax highlighting, indentation, and folding
-- LazyVim already installs: bash, c, html, js, ts, tsx, lua, markdown, json, yaml, etc.
-- Add parsers here; they merge with LazyVim's list via opts_extend
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      -- These are ON TOP of LazyVim's defaults (they merge, not replace):
      "css",
      "graphql",
      "dockerfile",
      "gitignore",
      "prisma",
      -- "rust",
      -- "go",
      -- "python",
    },

    -- highlight = { enable = true },   -- AST-based highlighting (default: on)
    -- indent   = { enable = true },    -- treesitter indentation (default: on)
    -- folds    = { enable = true },    -- treesitter folding (default: on)
  },
}
