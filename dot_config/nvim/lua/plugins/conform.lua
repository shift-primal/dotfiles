require('conform').setup({
	formatters_by_ft = {
		lua = { 'stylua' },
		cs = { 'csharpier' },
		sql = { 'sqlfluff' },
		toml = { 'tombi' },
		javascript = { 'prettier' },
		typescript = { 'prettier' },
		javascriptreact = { 'prettier' },
		typescriptreact = { 'prettier' },
		css = { 'prettier' },
		html = { 'prettier' },
		json = { 'prettier' },
		cpp = { 'clang_format' },
		arduino = { 'clang_format' },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = 'fallback',
	},

	formatters = {
		stylua = {
			prepend_args = { '--indent-type', 'Tabs', '--indent-width', '4' },
		},
		clang_format = {
			prepend_args = { '--style=file' },
		},
	},
})
