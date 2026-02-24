local H = "plugins.ui.highlights"

return function(c)
  local t = require(H .. ".tokens")(c)
  return {
    ["@comment"]               = { fg = t.comment, style = { "italic" } },
    ["@keyword"]               = { fg = t.keyword },
    ["@keyword.function"]      = { fg = t.keyword },
    ["@keyword.operator"]      = { fg = t.keyword },
    ["@keyword.return"]        = { fg = t.keyword },
    ["@keyword.import"]        = { fg = t.keyword },
    ["@keyword.modifier"]      = { fg = t.keyword },
    ["@operator"]              = { fg = t.operator },
    ["@function"]              = { fg = t.func },
    ["@function.call"]         = { fg = t.func },
    ["@function.builtin"]      = { fg = t.func },
    ["@method"]                = { fg = t.func },
    ["@method.call"]           = { fg = t.func },
    ["@constructor"]           = { fg = t.type },
    ["@type"]                  = { fg = t.type },
    ["@type.builtin"]          = { fg = t.type },
    ["@type.definition"]       = { fg = t.type },
    ["@variable"]              = { fg = t.variable },
    ["@variable.builtin"]      = { fg = t.keyword },  -- this, self, etc.
    ["@variable.parameter"]    = { fg = t.parameter, style = { "italic" } },
    ["@variable.member"]       = { fg = t.variable },
    ["@property"]              = { fg = t.property },
    ["@constant"]              = { fg = t.constant },
    ["@constant.builtin"]      = { fg = t.constant },
    ["@string"]                = { fg = t.string },
    ["@string.escape"]         = { fg = t.special },
    ["@number"]                = { fg = t.number },
    ["@boolean"]               = { fg = t.boolean },
    ["@tag"]                   = { fg = t.tag },
    ["@tag.attribute"]         = { fg = t.tag_attr },
    ["@tag.delimiter"]         = { fg = t.delimiter },
    ["@punctuation.bracket"]   = { fg = t.delimiter },
    ["@punctuation.delimiter"] = { fg = t.delimiter },
    ["@punctuation.special"]   = { fg = t.special },
    ["@namespace"]             = { fg = t.type },
    ["@parameter"]             = { fg = t.parameter, style = { "italic" } },
  }
end
