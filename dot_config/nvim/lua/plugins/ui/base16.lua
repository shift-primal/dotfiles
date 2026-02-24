local c = {
  -- ── UI palette (NvChad base46 port - the one you liked) ──────
  bg = "#141423",
  bg_dark = "#19192c",
  bg2 = "#1c1c31",
  bg3 = "#23233d",
  bg4 = "#2b2b4c",
  line = "#2D2D4E",
  grey = "#414171",
  grey_fg = "#4b4b83",
  grey_fg2 = "#555594",
  light_grey = "#6060a4",

  -- ── Syntax palette (official VSCode evondev JSON) ────────────
  fg = "#f8f8f2",
  comment = "#6272a4",
  pink = "#FF42B3",
  green = "#40DC99",
  blue = "#17B5FF",
  cyan = "#8BE9FD",
  purple = "#978df8",
  violet = "#BD93F9",
  lpurple = "#E28CFD",
  orange = "#FFB86C",
  red = "#FF5555",
  yellow = "#ffd700",
  str = "#EAC394",
  const = "#91b4d5",
  var = "#ced9f7",
  white = "#ffffff",
}

local palette = {
  base00 = c.bg,
  base01 = c.bg_dark,
  base02 = c.bg3,
  base03 = c.comment,
  base04 = c.light_grey,
  base05 = c.fg,
  base06 = c.fg,
  base07 = c.white,
  base08 = c.var,
  base09 = c.const,
  base0A = c.blue,
  base0B = c.str,
  base0C = c.cyan,
  base0D = c.green,
  base0E = c.pink,
  base0F = c.comment,
}

return {
  -- ── Colorscheme ───────────────────────────────────────────────
  {
    "nvim-mini/mini.base16",
    lazy = false,
    priority = 1000,
    config = function()
      require("mini.base16").setup({ palette = palette })
      local hi = function(g, o)
        vim.api.nvim_set_hl(0, g, o)
      end

      -- ── Core UI ────────────────────────────────────────────────
      hi("Normal", { fg = c.fg, bg = c.bg })
      hi("NormalFloat", { fg = c.fg, bg = c.bg2 })
      hi("FloatBorder", { fg = c.grey_fg, bg = c.bg2 })
      hi("WinSeparator", { fg = c.line })
      hi("VertSplit", { fg = c.line })
      hi("CursorLine", { bg = c.bg2 })
      hi("CursorLineNr", { fg = c.fg, bold = true })
      hi("LineNr", { fg = c.grey_fg, bg = c.bg })
      hi("SignColumn", { fg = c.grey_fg, bg = c.bg })
      hi("FoldColumn", { fg = c.grey_fg, bg = c.bg })
      hi("ColorColumn", { bg = c.bg_dark })

      -- ── Popup / Completion ─────────────────────────────────────
      hi("Pmenu", { fg = c.fg, bg = c.bg3 })
      hi("PmenuSel", { fg = c.fg, bg = c.bg4, bold = true })
      hi("PmenuSbar", { bg = c.bg3 })
      hi("PmenuThumb", { bg = c.light_grey })

      -- ── Telescope ──────────────────────────────────────────────
      hi("TelescopeNormal", { bg = c.bg2 })
      hi("TelescopeBorder", { fg = c.bg2, bg = c.bg2 })
      hi("TelescopePromptNormal", { bg = c.bg3 })
      hi("TelescopePromptBorder", { fg = c.bg3, bg = c.bg3 })
      hi("TelescopePromptTitle", { fg = c.pink, bold = true })
      hi("TelescopeResultsTitle", { fg = c.comment })
      hi("TelescopePreviewTitle", { fg = c.green, bold = true })
      hi("TelescopeSelection", { bg = c.bg4 })
      hi("TelescopeMatching", { fg = c.blue, bold = true })

      -- ── Neo-tree ───────────────────────────────────────────────
      hi("NeoTreeNormal", { fg = c.fg, bg = c.bg_dark })
      hi("NeoTreeNormalNC", { fg = c.fg, bg = c.bg_dark })
      hi("NeoTreeEndOfBuffer", { fg = c.bg_dark, bg = c.bg_dark })
      hi("NeoTreeWinSeparator", { fg = c.line, bg = c.bg })
      hi("NeoTreeRootName", { fg = c.violet, bold = true })
      hi("NeoTreeDirectoryName", { fg = c.fg })
      hi("NeoTreeDirectoryIcon", { fg = c.violet })
      hi("NeoTreeFileName", { fg = c.fg })
      hi("NeoTreeFileIcon", { fg = c.blue })
      hi("NeoTreeGitAdded", { fg = c.green })
      hi("NeoTreeGitModified", { fg = c.cyan })
      hi("NeoTreeGitDeleted", { fg = c.red })

      -- ── Tabs / Bufferline ──────────────────────────────────────
      hi("TabLine", { fg = c.grey_fg, bg = c.bg_dark })
      hi("TabLineFill", { bg = c.bg_dark })
      hi("TabLineSel", { fg = c.fg, bg = c.bg })

      -- ── Statusline ─────────────────────────────────────────────
      hi("StatusLine", { fg = c.fg, bg = c.bg_dark })
      hi("StatusLineNC", { fg = c.grey_fg, bg = c.bg_dark })

      -- ── Diagnostics ────────────────────────────────────────────
      hi("DiagnosticError", { fg = c.red })
      hi("DiagnosticWarn", { fg = c.orange })
      hi("DiagnosticInfo", { fg = c.cyan })
      hi("DiagnosticHint", { fg = c.purple })

      -- ── Syntax ─────────────────────────────────────────────────
      hi("@comment", { fg = c.comment, italic = true })
      hi("@variable", { fg = c.var })
      hi("@variable.member", { fg = c.var })
      hi("@variable.parameter", { fg = c.purple })
      hi("@variable.builtin", { fg = c.pink })
      hi("@function", { fg = c.green })
      hi("@function.builtin", { fg = c.green })
      hi("@function.call", { fg = c.green })
      hi("@function.method", { fg = c.green })
      hi("@function.method.call", { fg = c.green })
      hi("@constructor", { fg = c.blue })
      hi("@keyword", { fg = c.pink })
      hi("@keyword.function", { fg = c.pink })
      hi("@keyword.return", { fg = c.pink })
      hi("@keyword.operator", { fg = c.pink })
      hi("@keyword.import", { fg = c.pink })
      hi("@keyword.coroutine", { fg = c.lpurple, bold = true })
      hi("@type", { fg = c.blue })
      hi("@type.builtin", { fg = c.blue })
      hi("@string", { fg = c.str })
      hi("@string.escape", { fg = c.pink })
      hi("@number", { fg = c.const })
      hi("@float", { fg = c.const })
      hi("@boolean", { fg = c.const })
      hi("@constant", { fg = c.const })
      hi("@constant.builtin", { fg = "#7CAFFF" })
      hi("@operator", { fg = c.pink })
      hi("@punctuation.delimiter", { fg = c.fg })
      hi("@punctuation.special", { fg = c.pink })
      hi("@tag", { fg = c.pink })
      hi("@tag.builtin", { fg = c.pink })
      hi("@tag.attribute", { fg = c.green })
      hi("@tag.delimiter", { fg = c.white })

      -- ── LSP semantic tokens ────────────────────────────────────
      hi("@lsp.type.variable", { fg = c.var })
      hi("@lsp.type.parameter", { fg = c.purple })
      hi("@lsp.type.property", { fg = c.var })
      hi("@lsp.type.class", { fg = c.blue })
      hi("@lsp.type.interface", { fg = c.blue })
      hi("@lsp.type.type", { fg = c.blue })
      hi("@lsp.type.function", { fg = c.green })
      hi("@lsp.type.method", { fg = c.green })
      hi("@lsp.type.keyword", { fg = c.pink })

      -- ── Rainbow delimiters (defined here, activated in spec below)
      hi("RainbowDelimiterRed", { fg = c.red })
      hi("RainbowDelimiterYellow", { fg = c.yellow })
      hi("RainbowDelimiterBlue", { fg = c.violet })
      hi("RainbowDelimiterOrange", { fg = c.orange })
      hi("RainbowDelimiterGreen", { fg = c.green })
      hi("RainbowDelimiterViolet", { fg = c.pink })
      hi("RainbowDelimiterCyan", { fg = c.cyan })

      hi("@punctuation.bracket", { fg = c.fg })
    end,
  },

  -- ── Rainbow delimiters (explicit - not always on by default) ──
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rainbow = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters", -- default: all brackets
          tsx = "rainbow-parens", -- skip <> in JSX/TSX
          jsx = "rainbow-parens",
          html = "rainbow-parens",
          vue = "rainbow-parens",
          svelte = "rainbow-parens",
        },
        highlight = {
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterViolet",
        },
      }
    end,
  },

  -- ── Tell LazyVim not to override our colorscheme ───────────────
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("mini.base16").setup({ palette = palette })
      end,
    },
  },
}
