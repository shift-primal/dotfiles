-- Global LSP options shared across ALL servers.
-- Individual server opts live in lua/plugins/lsp/servers/*.lua
-- To add a new server: create servers/<name>.lua returning its opts, then require it below.

return {
  "neovim/nvim-lspconfig",
  opts = {
    -- Inlay hints: ghost text shown inline (e.g. parameter names, return types).
    -- Toggle at runtime with: vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    inlay_hints = {
      enabled = true,
    },

    -- Code lens: clickable actions shown above functions (e.g. "Run Test", "References").
    -- Requires server support. Enable per-server or globally here.
    codelens = {
      enabled = false,
    },

    -- UFO-compatible fold provider: lets LSP servers supply fold ranges.
    -- Requires a folding plugin (e.g. kevinhwang91/nvim-ufo) to actually render them.
    folds = {
      enabled = true,
    },

    servers = {
      vtsls = require("plugins.lsp.servers.vtsls"),
      tailwindcss = require("plugins.lsp.servers.tailwindcss"),
      marksman = require("plugins.lsp.servers.marksman"),
      docker_compose_language_service = require("plugins.lsp.servers.docker"),
    },
  },
}
