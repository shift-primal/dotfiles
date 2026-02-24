local H = "plugins.ui.highlights"

return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      custom_highlights = function(colors)
        -- Clear cache so edits to highlight files take effect without restarting nvim
        for k in pairs(package.loaded) do
          if k:match("^plugins%.ui%.highlights") then
            package.loaded[k] = nil
          end
        end
        local syntax = require(H .. ".syntax")(colors)
        local treesitter = require(H .. ".treesitter")(colors)
        local lsp = require(H .. ".lsp")(colors)
        local misc = require(H .. ".misc")(colors)
        return vim.tbl_extend("force", syntax, treesitter, lsp, misc)
      end,
      lsp_styles = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      auto_integrations = true,
    },
  },
  { "LazyVim/LazyVim", opts = {
    colorscheme = "dracula-darker",
  } },
  {
    -- :ReloadHighlights to pick up changes to highlight files without restarting
    "catppuccin/nvim",
    optional = true,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.api.nvim_create_user_command("ReloadHighlights", function()
        require("catppuccin").compile()
        vim.cmd.colorscheme(vim.g.colors_name)
      end, {})
    end,
  },
}
