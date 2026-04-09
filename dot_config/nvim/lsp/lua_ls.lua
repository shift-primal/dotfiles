return {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.stylua.toml', 'stylua.toml', '.git' },
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			workspace = {
				checkThirdParty = false,
			},
			diagnostics = { globals = { 'vim', 'Snacks' } },
			completion = { callSnippet = 'Replace' },
			hint = { enable = true },
			doc = { privateName = { '^_' } },
		},
	},
}
