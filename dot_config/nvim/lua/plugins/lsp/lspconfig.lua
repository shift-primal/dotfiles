return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = true,
    },

    codelens = {
      enabled = false,
    },

    folds = {
      enabled = true,
    },

    servers = {
      vtsls = {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = false },
              enumMemberValues = { enabled = true },
            },
          },
        },
      },

      tailwindcss = {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "cva\\(([^)]*)\\)",  "[\"'`]([^\"'`]*).*?[\"'`]" },   -- class-variance-authority
                { "cx\\(([^)]*)\\)",   "(?:'|\"|`)([^']*)(?:'|\"|`)" }, -- cx()
                { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" }, -- clsx()
                { "cn\\(([^)]*)\\)",   "(?:'|\"|`)([^']*)(?:'|\"|`)" }, -- shadcn cn()
              },
            },
          },
        },
      },
    },
  },
}
