return {
	"stevearc/conform.nvim",
	opts = function(_, opts)
		opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
			lua = { "stylua" },
			cs = { "csharpier" },
			sql = { "sqlfluff" },
			toml = { "tombi" },
			javascript = { "biome", "biome-organize-imports" },
			javascriptreact = { "biome", "biome-organize-imports" },
			typescript = { "biome", "biome-organize-imports" },
			typescriptreact = { "biome", "biome-organize-imports" },
			css = { "biome" },
			html = { "biome" },
			json = { "biome" },
		})

		opts.formatters = vim.tbl_extend("force", opts.formatter or {}, {
			stylua = {
				prepend_args = { "--indent-type", "Tabs", "--indent-width", "4" },
			},
		})
	end,
}
