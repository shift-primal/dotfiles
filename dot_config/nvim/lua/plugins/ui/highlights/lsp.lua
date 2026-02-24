local H = "plugins.ui.highlights"

return function(c)
  local t = require(H .. ".tokens")(c)
  return {
    ["@lsp.type.variable"]   = { fg = t.variable },
    ["@lsp.type.parameter"]  = { fg = t.parameter, style = { "italic" } },
    ["@lsp.type.property"]   = { fg = t.property },
    ["@lsp.type.function"]   = { fg = t.func },
    ["@lsp.type.method"]     = { fg = t.func },
    ["@lsp.type.type"]       = { fg = t.type },
    ["@lsp.type.class"]      = { fg = t.type },
    ["@lsp.type.interface"]  = { fg = t.type },
    ["@lsp.type.enum"]       = { fg = t.type },
    ["@lsp.type.enumMember"] = { fg = t.constant },
    ["@lsp.type.keyword"]    = { fg = t.keyword },
    ["@lsp.type.namespace"]  = { fg = t.type },
    ["@lsp.mod.readonly"]    = { fg = t.constant },
  }
end
