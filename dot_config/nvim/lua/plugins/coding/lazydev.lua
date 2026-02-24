-- lazydev.nvim — Lua LSP type stubs for Neovim's API, LazyVim, and Snacks
-- Makes lua_ls understand vim.*, Snacks.*, LazyVim.* while editing your config
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "LazyVim",            words = { "LazyVim" } },
      { path = "snacks.nvim",        words = { "Snacks" } },
      { path = "lazy.nvim",          words = { "LazyVim" } },
      -- Add more plugin type libraries here:
      -- { path = "wezterm-types", mods = { "wezterm" } },
    },
  },
}
