return {
	"stevearc/conform.nvim",
	opts = function(_, opts)
		opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
			lua = { "stylua" },
			cs = { "csharpier" },
			sql = { "sqlfluff" },
			toml = { "tombi" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			cpp = { "clang_format" },
			arduino = { "clang_format" },
		})

		opts.formatters = vim.tbl_extend("force", opts.formatter or {}, {
			stylua = {
				prepend_args = { "--indent-type", "Tabs", "--indent-width", "4" },
			},
			clang_format = {
				prepend_args = { "--style=file" },
			},
		})
	end,
}
