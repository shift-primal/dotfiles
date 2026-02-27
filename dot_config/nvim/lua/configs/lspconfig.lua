require("nvchad.configs.lspconfig").defaults()

-- Disable built-in virtual text so tiny-inline-diagnostic renders instead
vim.diagnostic.config({ virtual_text = false })

local servers = { "html", "cssls", "tailwindcss" }
vim.lsp.enable(servers)

vim.lsp.config("vtsls", {
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        returnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        returnTypes = { enabled = true },
      },
    },
    vtsls = {
      enableMoveToFileCodeAction = true,
    },
  },
})

vim.lsp.enable "vtsls"
