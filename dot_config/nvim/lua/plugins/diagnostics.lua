-- Disable vim diagnostics virtual text

vim.diagnostic.config({
	virtual_text = false,
})

require('tiny-inline-diagnostic').setup({
	preset = 'modern', -- or 'classic', 'simple', 'nonerdfont'
	signs = {
		left = '',
		right = '',
		diag = '●',
		arrow = '    ',
		up_arrow = '    ',
		vertical = ' │',
		vertical_end = ' └',
	},
	options = {
		show_source = false,
		throttle = 20,
		softwrap = 15,
		multilines = {
			enabled = true,
			always_show = false,
		},
	},
})
