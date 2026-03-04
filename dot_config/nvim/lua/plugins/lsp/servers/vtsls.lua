return {
  settings = {
    typescript = {
      suggest = {
        -- Show auto-import completions (e.g. typing "useState" suggests importing from React).
        autoImports = true,

        -- Include exported module members in completions even if not yet imported.
        -- Disable if completions feel too noisy.
        includeCompletionsForModuleExports = true,
      },

      inlayHints = {
        -- Show parameter names as ghost text when calling functions.
        -- "none" | "literals" (only for literal values) | "all"
        parameterNames = { enabled = "all" },

        -- Show inferred parameter types (e.g. `(x: number)`).
        parameterTypes = { enabled = true },

        -- Show inferred variable types. Can be verbose — enable if you want explicit types everywhere.
        variableTypes = { enabled = false },

        -- Show inferred property types in object/class declarations.
        propertyDeclarationTypes = { enabled = true },

        -- Show inferred return types on function declarations.
        -- Useful but can clutter short functions — toggle to taste.
        functionLikeReturnTypes = { enabled = false },

        -- Show resolved enum member values (e.g. `Direction.Up = 0`).
        enumMemberValues = { enabled = true },
      },
    },
  },
}
