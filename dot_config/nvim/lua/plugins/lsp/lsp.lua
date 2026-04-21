return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			vtsls = require("plugins.lsp.servers.vtsls"),
		},
	},
}
