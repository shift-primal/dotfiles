-- Autopairs / autotags
require('nvim-ts-autotag').setup()
require('nvim-autopairs').setup({
	check_ts = true,
})

-- Git signs in the gutter + hunk utilities
require('gitsigns').setup()

-- Trim (strip whitespace)
require('trim').setup()

require('grug-far').setup()
require('flash').setup({
	search = { multi_window = false },
})

local map = vim.keymap.set
map({ 'n', 'x', 'o' }, 's', function()
	require('flash').jump()
end, { desc = 'Flash', nowait = true })
map({ 'n', 'x', 'o' }, 'S', function()
	require('flash').treesitter()
end, { desc = 'Flash Treesitter', nowait = true })
map('o', 'r', function()
	require('flash').remote()
end, { desc = 'Remote Flash' })
map({ 'o', 'x' }, 'R', function()
	require('flash').treesitter_search()
end, { desc = 'Treesitter Search' })
map('c', '<c-s>', function()
	require('flash').toggle()
end, { desc = 'Toggle Flash Search' })
map({ 'n', 'o', 'x' }, '<c-space>', function()
	require('flash').treesitter({
		actions = {
			['<c-space>'] = 'next',
			['<bs>'] = 'prev',
		},
	})
end, { desc = 'Treesitter Incremental Selection' })
