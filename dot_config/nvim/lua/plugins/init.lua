return {

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy",
      priority = 1000,
      opts = {},
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require "configs.treesitter"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "vtsls",
        "tailwindcss-language-server",
        "html-lsp",
        "css-lsp",
        "prettier",
        "stylua",
        "roslyn",
      },
    },
  },

  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      filewatching = "auto",
      config = {
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_types = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
        },
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        adaptive_size = true,
      },
      renderer = {
        icons = {
          glyphs = {
            git = { unstaged = "➜" },
          },
        },
      },
    },
  },

  { import = "nvchad.blink.lazyspec" },

  {
    "saghen/blink.cmp",
    opts = {
      cmdline = {
        completion = {
          menu = { auto_show = true },
        },
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPost",
    config = true,
  },
}
