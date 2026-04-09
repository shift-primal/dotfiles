require('snacks').setup({
	indent = {
		terminal = {
			win = { style = 'terminal' },
		},
	},
	explorer = {},
	notifier = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	zen = { enabled = true },
	quickfile = { enabled = true },
})

local map = vim.keymap.set
map('n', '<leader>e', function()
	Snacks.explorer()
end, { desc = 'Toggle File Explorer' })
map('n', '<leader>fe', function()
	Snacks.explorer({ reveal = true })
end, { desc = 'Reveal File in Explorer' })
