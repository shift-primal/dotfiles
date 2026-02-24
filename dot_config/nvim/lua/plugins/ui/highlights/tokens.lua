-- Single source of truth for semantic color choices.
-- Change a color here and it updates across syntax, treesitter, and LSP.
-- Based on evondev Dracula High Contrast, mapped to Catppuccin Mocha colors.
return function(c)
  return {
    keyword   = c.pink,
    operator  = c.pink,
    func      = c.teal,
    type      = c.sky,
    variable  = c.lavender,
    constant  = c.mauve,
    string    = c.peach,
    number    = c.mauve,
    boolean   = c.mauve,
    parameter = c.peach,
    property  = c.green,
    tag       = c.pink,
    tag_attr  = c.teal,
    delimiter = c.text,
    comment   = c.overlay1,
    special   = c.pink,
    error     = c.red,
  }
end
