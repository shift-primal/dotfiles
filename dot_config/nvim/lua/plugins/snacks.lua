require('snacks').setup({
	indent = { enabled = true },
	terminal = {
		win = { style = 'terminal' },
	},
	dashboard = {},
	explorer = {},
	picker = { enabled = true },
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

map('n', '<leader>ff', function()
	Snacks.picker.files()
end, { desc = 'Find Files' })

map('n', '<leader>fp', function()
	Snacks.picker.projects()
end, { desc = 'Projects' })

map('n', '<leader>fr', function()
	Snacks.picker.recent()
end, {
	desc = 'Recent',
})

map('n', '<leader>fc', function()
	Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Find Config File' })

map('n', '<leader>/', function()
	Snacks.picker.grep()
end, { desc = 'Grep' })
