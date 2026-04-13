local function augroup(name)
	return vim.api.nvim_create_augroup('nvim_' .. name, { clear = true })
end

-- Reload file if it changed on disk
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
	group = augroup('checktime'),
	callback = function()
		if vim.o.buftype ~= 'nofile' then
			vim.cmd('checktime')
		end
	end,
})

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd('TextYankPost', {
	group = augroup('highlight_yank'),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Equalize splits when Neovim is resized
vim.api.nvim_create_autocmd('VimResized', {
	group = augroup('resize_splits'),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd('tabdo wincmd =')
		vim.cmd('tabnext ' .. current_tab)
	end,
})

-- Jump to last known cursor position when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
	group = augroup('last_loc'),
	callback = function(event)
		local buf = event.buf
		if vim.tbl_contains({ 'gitcommit' }, vim.bo[buf].filetype) or vim.b[buf].last_loc then
			return
		end
		vim.b[buf].last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Close ephemeral windows with <q>
vim.api.nvim_create_autocmd('FileType', {
	group = augroup('close_with_q'),
	pattern = {
		'checkhealth',
		'help',
		'lspinfo',
		'qf',
		'man',
		'startuptime',
		'tsplayground',
		'notify',
		'gitsigns-blame',
		'grug-far',
		'spectre_panel',
		'PlenaryTestPopup',
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set('n', 'q', function()
				vim.cmd('close')
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, { buffer = event.buf, silent = true, desc = 'Close window' })
		end)
	end,
})

-- Enable wrap for prose filetypes
vim.api.nvim_create_autocmd('FileType', {
	group = augroup('wrap_spell'),
	pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
	callback = function()
		vim.opt_local.wrap = true
	end,
})

-- Disable conceal for JSON (so you can actually read the raw text)
vim.api.nvim_create_autocmd('FileType', {
	group = augroup('json_conceal'),
	pattern = { 'json', 'jsonc', 'json5' },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Auto-create parent directories on save
vim.api.nvim_create_autocmd('BufWritePre', {
	group = augroup('auto_create_dir'),
	callback = function(event)
		if event.match:match('^%w%w+:[\\/][\\/]') then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
	end,
})

-- Remove man pages from buffer list so they don't pollute buffer cycling
vim.api.nvim_create_autocmd('FileType', {
	group = augroup('man_unlisted'),
	pattern = 'man',
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- Bootstrap the Arduino integration for every .ino buffer.
vim.api.nvim_create_autocmd('FileType', {
	group = augroup('arduino_setup'),
	pattern = 'arduino',
	callback = function()
		require('arduino').setup()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.expandtab = true
	end,
})
