return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			vtsls = require("plugins.lsp.servers.vtsls"),
			basedpyright = require("plugins.lsp.servers.basedpyright"),
		},
	},
}
