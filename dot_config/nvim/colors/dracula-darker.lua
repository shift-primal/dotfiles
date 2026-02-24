-- dracula-darker.lua
-- Neovim colorscheme based on evondev's Dracula Darker Contrast
-- https://github.com/evondev/evondev-dracula

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.o.termguicolors = true
vim.g.colors_name = "dracula-darker"

local c = {
  -- Base
  bg        = "#141423",
  fg        = "#E9E9F4",
  cursor    = "#373760",
  cursor_fg = "#F7F7FB",

  -- Syntax roles (mapped from terminal palette)
  purple    = "#FF5555",    -- c1: types, classes
  yellow    = "#20E3B2",    -- c2: strings, attributes
  cyan_dim  = "#FDE181",    -- c3: numbers, booleans
  green     = "#BD93F9",    -- c4: functions, methods
  pink      = "#FF6BCB",    -- c5: keywords, operators (accent)
  cyan      = "#8BE9FD",    -- c6: constants, builtins
  muted     = "#7e7eb5",  -- comments, line numbers
  bright_fg = "#F1F2F8",  -- bright foreground

  -- UI chrome (derived from palette)
  bg_dark       = "#11111e",
  bg_float      = "#262644",
  bg_visual     = "#37213c",
  bg_cursorline = "#22233d",
  border        = "#8D92FF",
  selection     = "#505391",

  -- Diagnostics
  error = "#ff5555",
  warn  = "#20E3B2",
  info  = "#FDE181",
  hint  = "#BD93F9",

  -- Git
  git_add    = "#BD93F9",
  git_change = "#FDE181",
  git_delete = "#ff5555",

  -- Diff (tinted backgrounds)
  diff_add    = "#28233c",
  diff_change = "#2f2c2e",
  diff_delete = "#301e37",
  diff_text   = "#474137",

  none = "NONE",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ─── Editor UI ────────────────────────────────────────────────────────────────
hl("Normal",          { fg = c.fg,        bg = c.bg })
hl("NormalFloat",     { fg = c.fg,        bg = c.bg_float })
hl("NormalNC",        { fg = c.fg,        bg = c.bg })
hl("FloatBorder",     { fg = c.border,    bg = c.bg_float })
hl("FloatTitle",      { fg = c.purple,    bg = c.bg_float, bold = true })

hl("Cursor",          { fg = c.bg,        bg = c.cursor_fg })
hl("CursorIM",        { fg = c.bg,        bg = c.cursor_fg })
hl("CursorLine",      { bg = c.bg_cursorline })
hl("CursorColumn",    { bg = c.bg_cursorline })
hl("ColorColumn",     { bg = c.bg_float })

hl("LineNr",          { fg = c.border })
hl("CursorLineNr",    { fg = c.purple,    bold = true })
hl("SignColumn",      { fg = c.border,    bg = c.bg })
hl("FoldColumn",      { fg = c.border,    bg = c.bg })
hl("Folded",          { fg = c.muted,     bg = c.bg_float })

hl("Visual",          { bg = c.bg_visual })
hl("VisualNOS",       { bg = c.bg_visual })

hl("Search",          { fg = c.bg,        bg = c.pink,   bold = true })
hl("IncSearch",       { fg = c.bg,        bg = c.yellow, bold = true })
hl("CurSearch",       { fg = c.bg,        bg = c.yellow, bold = true })
hl("Substitute",      { fg = c.bg,        bg = c.pink })

hl("StatusLine",      { fg = c.fg,        bg = c.bg_dark })
hl("StatusLineNC",    { fg = c.muted,     bg = c.bg_dark })
hl("WinBar",          { fg = c.fg,        bg = c.bg })
hl("WinBarNC",        { fg = c.muted,     bg = c.bg })
hl("WinSeparator",    { fg = c.border })

hl("TabLine",         { fg = c.muted,     bg = c.bg_dark })
hl("TabLineSel",      { fg = c.fg,        bg = c.bg,      bold = true })
hl("TabLineFill",     { bg = c.bg_dark })

hl("Pmenu",           { fg = c.fg,        bg = c.bg_float })
hl("PmenuSel",        { fg = c.bg,        bg = c.purple,  bold = true })
hl("PmenuSbar",       { bg = c.bg_float })
hl("PmenuThumb",      { bg = c.border })

hl("MatchParen",      { fg = c.cyan,      bold = true, underline = true })
hl("NonText",         { fg = c.border })
hl("SpecialKey",      { fg = c.border })
hl("Whitespace",      { fg = c.border })
hl("EndOfBuffer",     { fg = c.border })

hl("Directory",       { fg = c.cyan,      bold = true })
hl("Title",           { fg = c.purple,    bold = true })
hl("Question",        { fg = c.green })
hl("MoreMsg",         { fg = c.green })
hl("ModeMsg",         { fg = c.yellow,    bold = true })

hl("ErrorMsg",        { fg = c.error,     bold = true })
hl("WarningMsg",      { fg = c.warn })

hl("DiffAdd",         { bg = c.diff_add })
hl("DiffChange",      { bg = c.diff_change })
hl("DiffDelete",      { fg = c.git_delete, bg = c.diff_delete })
hl("DiffText",        { bg = c.diff_text })

hl("SpellBad",        { undercurl = true, sp = c.error })
hl("SpellCap",        { undercurl = true, sp = c.warn })
hl("SpellLocal",      { undercurl = true, sp = c.info })
hl("SpellRare",       { undercurl = true, sp = c.hint })

-- ─── Syntax ───────────────────────────────────────────────────────────────────
hl("Comment",         { fg = c.muted,  italic = true })
hl("Constant",        { fg = c.cyan })
hl("String",          { fg = c.yellow })
hl("Character",       { fg = c.yellow })
hl("Number",          { fg = c.cyan_dim })
hl("Float",           { fg = c.cyan_dim })
hl("Boolean",         { fg = c.cyan_dim, italic = true })

hl("Identifier",      { fg = c.fg })
hl("Function",        { fg = c.green })

hl("Statement",       { fg = c.pink })
hl("Conditional",     { fg = c.pink })
hl("Repeat",          { fg = c.pink })
hl("Label",           { fg = c.pink })
hl("Operator",        { fg = c.pink })
hl("Keyword",         { fg = c.pink })
hl("Exception",       { fg = c.pink })

hl("PreProc",         { fg = c.cyan })
hl("Include",         { fg = c.pink })
hl("Define",          { fg = c.pink })
hl("Macro",           { fg = c.cyan })
hl("PreCondit",       { fg = c.pink })

hl("Type",            { fg = c.purple })
hl("StorageClass",    { fg = c.pink })
hl("Structure",       { fg = c.purple })
hl("Typedef",         { fg = c.purple })

hl("Special",         { fg = c.cyan_dim })
hl("SpecialChar",     { fg = c.cyan_dim })
hl("Tag",             { fg = c.pink })
hl("Delimiter",       { fg = c.fg })
hl("SpecialComment",  { fg = c.muted, italic = true })
hl("Debug",           { fg = c.warn })

hl("Underlined",      { underline = true })
hl("Ignore",          { fg = c.muted })
hl("Error",           { fg = c.error,    bold = true })
hl("Todo",            { fg = c.bg,       bg = c.cyan, bold = true })

-- ─── Tree-sitter ──────────────────────────────────────────────────────────────
hl("@comment",                   { link = "Comment" })
hl("@comment.documentation",     { fg = c.muted, italic = true })
hl("@error",                     { fg = c.error })

hl("@keyword",                   { fg = c.pink })
hl("@keyword.function",          { fg = c.pink })
hl("@keyword.operator",          { fg = c.pink })
hl("@keyword.return",            { fg = c.pink })
hl("@keyword.import",            { fg = c.pink })
hl("@keyword.modifier",          { fg = c.pink })
hl("@keyword.coroutine",         { fg = c.pink })
hl("@keyword.conditional",       { fg = c.pink })
hl("@keyword.repeat",            { fg = c.pink })
hl("@keyword.exception",         { fg = c.pink })

hl("@function",                  { fg = c.green })
hl("@function.builtin",          { fg = c.cyan })
hl("@function.call",             { fg = c.green })
hl("@function.macro",            { fg = c.cyan })
hl("@function.method",           { fg = c.green })
hl("@function.method.call",      { fg = c.green })

hl("@constructor",               { fg = c.purple })

hl("@variable",                  { fg = c.fg })
hl("@variable.builtin",          { fg = c.cyan,   italic = true })
hl("@variable.parameter",        { fg = c.fg,     italic = true })
hl("@variable.member",           { fg = c.fg })

hl("@type",                      { fg = c.purple })
hl("@type.builtin",              { fg = c.purple, italic = true })
hl("@type.definition",           { fg = c.purple })

hl("@string",                    { fg = c.yellow })
hl("@string.escape",             { fg = c.cyan_dim })
hl("@string.special",            { fg = c.cyan_dim })
hl("@string.regex",              { fg = c.cyan_dim })

hl("@number",                    { fg = c.cyan_dim })
hl("@number.float",              { fg = c.cyan_dim })
hl("@boolean",                   { fg = c.cyan_dim, italic = true })
hl("@constant",                  { fg = c.cyan })
hl("@constant.builtin",          { fg = c.cyan,   italic = true })
hl("@constant.macro",            { fg = c.cyan })

hl("@operator",                  { fg = c.pink })
hl("@punctuation.delimiter",     { fg = c.fg })
hl("@punctuation.bracket",       { fg = c.fg })
hl("@punctuation.special",       { fg = c.cyan_dim })

hl("@namespace",                 { fg = c.purple })
hl("@module",                    { fg = c.purple })
hl("@label",                     { fg = c.cyan_dim })
hl("@tag",                       { fg = c.pink })
hl("@tag.attribute",             { fg = c.yellow })
hl("@tag.delimiter",             { fg = c.muted })

hl("@attribute",                 { fg = c.yellow })
hl("@property",                  { fg = c.fg })

-- ─── LSP ──────────────────────────────────────────────────────────────────────
hl("LspReferenceText",           { bg = c.selection })
hl("LspReferenceRead",           { bg = c.selection })
hl("LspReferenceWrite",          { bg = c.selection, underline = true })
hl("LspCodeLens",                { fg = c.muted, italic = true })
hl("LspInlayHint",               { fg = c.border, italic = true })
hl("LspSignatureActiveParameter", { fg = c.yellow, bold = true })

-- ─── Diagnostics ──────────────────────────────────────────────────────────────
hl("DiagnosticError",            { fg = c.error })
hl("DiagnosticWarn",             { fg = c.warn })
hl("DiagnosticInfo",             { fg = c.info })
hl("DiagnosticHint",             { fg = c.hint })
hl("DiagnosticOk",               { fg = c.green })
hl("DiagnosticUnnecessary",      { fg = c.muted })

hl("DiagnosticUnderlineError",   { undercurl = true, sp = c.error })
hl("DiagnosticUnderlineWarn",    { undercurl = true, sp = c.warn })
hl("DiagnosticUnderlineInfo",    { undercurl = true, sp = c.info })
hl("DiagnosticUnderlineHint",    { undercurl = true, sp = c.hint })

hl("DiagnosticVirtualTextError", { fg = c.error, italic = true })
hl("DiagnosticVirtualTextWarn",  { fg = c.warn,  italic = true })
hl("DiagnosticVirtualTextInfo",  { fg = c.info,  italic = true })
hl("DiagnosticVirtualTextHint",  { fg = c.hint,  italic = true })

hl("DiagnosticSignError",        { fg = c.error })
hl("DiagnosticSignWarn",         { fg = c.warn })
hl("DiagnosticSignInfo",         { fg = c.info })
hl("DiagnosticVirtualLinesError",{ fg = c.error, italic = true })
hl("DiagnosticVirtualLinesWarn", { fg = c.warn,  italic = true })
hl("DiagnosticVirtualLinesInfo", { fg = c.info,  italic = true })
hl("DiagnosticVirtualLinesHint", { fg = c.hint,  italic = true })

-- ─── Git Signs ────────────────────────────────────────────────────────────────
hl("GitSignsAdd",                { fg = c.git_add })
hl("GitSignsChange",             { fg = c.git_change })
hl("GitSignsDelete",             { fg = c.git_delete })

-- ─── Telescope ────────────────────────────────────────────────────────────────
hl("TelescopeNormal",            { fg = c.fg,     bg = c.bg_float })
hl("TelescopeBorder",            { fg = c.border, bg = c.bg_float })
hl("TelescopePromptNormal",      { fg = c.fg,     bg = c.bg_dark })
hl("TelescopePromptBorder",      { fg = c.border, bg = c.bg_dark })
hl("TelescopePromptTitle",       { fg = c.bg,     bg = c.pink, bold = true })
hl("TelescopePreviewTitle",      { fg = c.bg,     bg = c.green, bold = true })
hl("TelescopeResultsTitle",      { fg = c.bg,     bg = c.purple, bold = true })
hl("TelescopeMatching",          { fg = c.cyan,   bold = true })
hl("TelescopeSelection",         { bg = c.bg_visual })
hl("TelescopeSelectionCaret",    { fg = c.pink,   bg = c.bg_visual })

-- ─── nvim-tree / neo-tree ─────────────────────────────────────────────────────
hl("NvimTreeNormal",             { fg = c.fg,     bg = c.bg_float })
hl("NvimTreeFolderName",         { fg = c.cyan })
hl("NvimTreeOpenedFolderName",   { fg = c.cyan,   bold = true })
hl("NvimTreeRootFolder",         { fg = c.pink,   bold = true })
hl("NvimTreeGitDirty",           { fg = c.warn })
hl("NvimTreeGitNew",             { fg = c.git_add })
hl("NvimTreeGitDeleted",         { fg = c.git_delete })
hl("NvimTreeSpecialFile",        { fg = c.yellow, underline = true })

hl("NeoTreeNormal",              { fg = c.fg,     bg = c.bg_float })
hl("NeoTreeNormalNC",            { fg = c.fg,     bg = c.bg_float })
hl("NeoTreeDirectoryName",       { fg = c.cyan })
hl("NeoTreeDirectoryIcon",       { fg = c.cyan })
hl("NeoTreeRootName",            { fg = c.pink,   bold = true })
hl("NeoTreeGitAdded",            { fg = c.git_add })
hl("NeoTreeGitModified",         { fg = c.git_change })
hl("NeoTreeGitDeleted",          { fg = c.git_delete })

-- ─── which-key ────────────────────────────────────────────────────────────────
hl("WhichKey",                   { fg = c.cyan })
hl("WhichKeyGroup",              { fg = c.purple })
hl("WhichKeyDesc",               { fg = c.fg })
hl("WhichKeySeparator",          { fg = c.muted })
hl("WhichKeyFloat",              { bg = c.bg_float })

-- ─── nvim-cmp ─────────────────────────────────────────────────────────────────
hl("CmpItemAbbr",                { fg = c.fg })
hl("CmpItemAbbrDeprecated",      { fg = c.muted,  strikethrough = true })
hl("CmpItemAbbrMatch",           { fg = c.cyan,   bold = true })
hl("CmpItemAbbrMatchFuzzy",      { fg = c.cyan })
hl("CmpItemKindFunction",        { fg = c.green })
hl("CmpItemKindMethod",          { fg = c.green })
hl("CmpItemKindConstructor",     { fg = c.purple })
hl("CmpItemKindClass",           { fg = c.purple })
hl("CmpItemKindInterface",       { fg = c.purple })
hl("CmpItemKindStruct",          { fg = c.purple })
hl("CmpItemKindVariable",        { fg = c.fg })
hl("CmpItemKindField",           { fg = c.fg })
hl("CmpItemKindProperty",        { fg = c.fg })
hl("CmpItemKindKeyword",         { fg = c.pink })
hl("CmpItemKindSnippet",         { fg = c.yellow })
hl("CmpItemKindText",            { fg = c.muted })
hl("CmpItemKindModule",          { fg = c.yellow })
hl("CmpItemKindValue",           { fg = c.cyan_dim })
hl("CmpItemKindEnum",            { fg = c.cyan_dim })
hl("CmpItemKindEnumMember",      { fg = c.cyan_dim })
hl("CmpItemKindConstant",        { fg = c.cyan })
hl("CmpItemKindTypeParameter",   { fg = c.purple })
hl("CmpItemMenu",                { fg = c.muted })

-- ─── Indent Blankline ─────────────────────────────────────────────────────────
hl("IblIndent",                  { fg = c.border })
hl("IblScope",                   { fg = c.cursor })
hl("IndentBlanklineChar",        { fg = c.border })
hl("IndentBlanklineContextChar", { fg = c.cursor })

-- ─── Illuminate ───────────────────────────────────────────────────────────────
hl("IlluminatedWordText",        { bg = c.selection })
hl("IlluminatedWordRead",        { bg = c.selection })
hl("IlluminatedWordWrite",       { bg = c.selection, underline = true })

-- ─── Flash / Leap ─────────────────────────────────────────────────────────────
hl("FlashBackdrop",              { fg = c.muted })
hl("FlashLabel",                 { fg = c.bg, bg = c.pink, bold = true })
hl("FlashMatch",                 { fg = c.bg, bg = c.cyan })
hl("FlashCurrent",               { fg = c.bg, bg = c.yellow })

-- ─── Noice / Notify ───────────────────────────────────────────────────────────
hl("NoiceCmdlinePopup",          { fg = c.fg,   bg = c.bg_float })
hl("NoiceCmdlinePopupBorder",    { fg = c.border })
hl("NoiceMini",                  { fg = c.fg,   bg = c.bg_dark })
hl("NotifyERRORBorder",          { fg = c.error })
hl("NotifyWARNBorder",           { fg = c.warn })
hl("NotifyINFOBorder",           { fg = c.info })
hl("NotifyDEBUGBorder",          { fg = c.muted })
hl("NotifyERRORTitle",           { fg = c.error, bold = true })
hl("NotifyWARNTitle",            { fg = c.warn,  bold = true })
hl("NotifyINFOTitle",            { fg = c.info,  bold = true })

-- ─── Terminal ─────────────────────────────────────────────────────────────────
vim.g.terminal_color_0  = "#141423"
vim.g.terminal_color_1  = "#FF5555"
vim.g.terminal_color_2  = "#20E3B2"
vim.g.terminal_color_3  = "#FDE181"
vim.g.terminal_color_4  = "#BD93F9"
vim.g.terminal_color_5  = "#FF6BCB"
vim.g.terminal_color_6  = "#8BE9FD"
vim.g.terminal_color_7  = "#E9E9F4"
vim.g.terminal_color_8  = "#8D92FF"
vim.g.terminal_color_9  = "#FF6E6E"
vim.g.terminal_color_10 = "#20E3B2"
vim.g.terminal_color_11 = "#EAC394"
vim.g.terminal_color_12 = "#BD93F9"
vim.g.terminal_color_13 = "#FF6BCB"
vim.g.terminal_color_14 = "#2CCCFF"
vim.g.terminal_color_15 = "#F1F2F8"
