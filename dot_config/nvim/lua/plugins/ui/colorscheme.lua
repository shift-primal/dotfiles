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
