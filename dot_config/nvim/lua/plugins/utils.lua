-- Which-key
require('which-key').setup({
	preset = 'modern',
	delay = 300,
})

require('which-key').add({
	{ '<leader>b', group = 'Buffer' },
	{ '<leader>c', group = 'Code' },
	{ '<leader>f', group = 'Find' },
	{ '<leader>g', group = 'Git' },
	{ '<leader>u', group = 'Toggle' },
	{ '<leader>w', group = 'Window' },
	{ '<leader>x', group = 'Quickfix' },
	{ '<leader><tab>', group = 'Tabs' },
	{ '<leader>D', group = 'Database' },
	{ '<leader>a', group = 'Arduino' },
	{ '<leader>T', group = 'Checkmate' },
})

-- Discord Rich Presence
require('cord').setup()
