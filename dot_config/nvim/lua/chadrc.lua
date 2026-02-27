local M = {}

M.base46 = {
  theme = "catppuccin",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    -- Red undercurl for error diagnostics (sp = special/underline color)
    DiagnosticUnderlineError = { sp = "#f38ba8", undercurl = true },
    -- Yellow for unstaged git changes in nvim-tree (instead of Statement → red)
    NvimTreeGitDirty = { fg = "#f9e2af" },
  },
  transparency = true,
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
  },
}

return M
