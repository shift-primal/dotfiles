return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		opts = function()
			local palette = require("gruvbox").palette
			return {
				overrides = {
					["@tag.delimiter"] = { fg = palette.light1 },
					["@tag.delimiter.jsx"] = { fg = palette.light1 },
					["@tag.delimiter.tsx"] = { fg = palette.light1 },
					LspReferenceText = { bg = palette.dark1, bold = false },
					LspReferenceRead = { bg = palette.dark1, bold = false },
					LspReferenceWrite = { bg = palette.dark2, bold = false },
				},
			}
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},
}
