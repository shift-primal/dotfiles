-- UI, diff, markdown, and other misc highlight groups
return function(c)
  local darken = require("catppuccin.utils.colors").darken
  return {
    -- UI
    qfLineNr = { fg = c.yellow },
    qfFileName = { fg = c.blue },
    htmlH1 = { fg = c.pink, style = { "bold" } },
    htmlH2 = { fg = c.blue, style = { "bold" } },
    mkdCodeDelimiter = { bg = c.base, fg = c.text },
    mkdCodeStart = { fg = c.flamingo, style = { "bold" } },
    mkdCodeEnd = { fg = c.flamingo, style = { "bold" } },
    debugPC = { bg = c.crust },
    debugBreakpoint = { bg = c.base, fg = c.overlay0 },
    illuminatedWord = { bg = c.surface1 },
    illuminatedCurWord = { bg = c.surface1 },

    -- Diagnostics
    healthError = { fg = c.red },
    healthSuccess = { fg = c.teal },
    healthWarning = { fg = c.yellow },

    -- Diff
    Added = { fg = c.green },
    Changed = { fg = c.blue },
    diffAdded = { fg = c.green },
    diffRemoved = { fg = c.red },
    diffChanged = { fg = c.blue },
    diffOldFile = { fg = c.yellow },
    diffNewFile = { fg = c.peach },
    diffFile = { fg = c.blue },
    diffLine = { fg = c.overlay0 },
    diffIndexLine = { fg = c.teal },
    DiffAdd = { bg = darken(c.green, 0.18, c.base) },
    DiffChange = { bg = darken(c.blue, 0.07, c.base) },
    DiffDelete = { bg = darken(c.red, 0.18, c.base) },
    DiffText = { bg = darken(c.blue, 0.30, c.base) },

    -- Rainbow headings
    rainbow1 = { fg = c.red },
    rainbow2 = { fg = c.peach },
    rainbow3 = { fg = c.yellow },
    rainbow4 = { fg = c.green },
    rainbow5 = { fg = c.sapphire },
    rainbow6 = { fg = c.lavender },

    -- Markdown
    markdownHeadingDelimiter = { fg = c.peach, style = { "bold" } },
    markdownCode = { fg = c.flamingo },
    markdownCodeBlock = { fg = c.flamingo },
    markdownLinkText = { fg = c.blue, style = { "underline" } },
    markdownH1 = { link = "rainbow1" },
    markdownH2 = { link = "rainbow2" },
    markdownH3 = { link = "rainbow3" },
    markdownH4 = { link = "rainbow4" },
    markdownH5 = { link = "rainbow5" },
    markdownH6 = { link = "rainbow6" },
  }
end
