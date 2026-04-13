local map = vim.keymap.set

-- Better up/down on wrapped lines
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })

-- Window resize
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Window splits
map('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below', remap = true })
map('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right', remap = true })
map('n', '<leader>wq', '<C-W>c', { desc = 'Delete Window', remap = true })

-- Move lines
map('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Line Down' })
map('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Line Up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Line Down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Line Up' })
map('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv", { desc = 'Move Line Down' })
map(
	'v',
	'<A-k>',
	":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv",
	{ desc = 'Move Line Up' }
)

-- Buffers
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', 'åb', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '¨b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>bD', '<cmd>bd<cr>', { desc = 'Delete Buffer and Window' })
map('n', '<leader>bd', function()
	local buf = vim.api.nvim_get_current_buf()
	vim.cmd('bprevious')
	vim.api.nvim_buf_delete(buf, { force = false })
end, { desc = 'Delete Buffer' })
map('n', '<leader>bo', '<cmd>%bd|e#|bd#<cr>', { desc = 'Delete Other Buffers' })

-- Clear hlsearch on escape
map({ 'i', 'n', 's' }, '<esc>', function()
	vim.cmd('noh')
	return '<esc>'
end, { expr = true, desc = 'Escape and Clear hlsearch' })

-- Redraw / clear hlsearch / diff update
map(
	'n',
	'<leader>ur',
	'<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><cr>',
	{ desc = 'Redraw / Clear hlsearch / Diff Update' }
)

-- Saner n/N (always forward/backward regardless of search direction)
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- Undo break-points in insert mode
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', ';', ';<C-g>u')

-- Save
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- Better indenting (stay in visual mode)
map('x', '<', '<gv')
map('x', '>', '>gv')

-- Comments (uses built-in gcc, added in 0.10)
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- Files
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- Quickfix / location list
map('n', 'åq', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', '¨q', vim.cmd.cnext, { desc = 'Next Quickfix' })
map('n', '<leader>xq', function()
	local ok, err =
		pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
	if not ok and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = 'Quickfix List' })
map('n', '<leader>xl', function()
	local ok, err =
		pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
	if not ok and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = 'Location List' })

-- Format (via conform, falls back to LSP)
map({ 'n', 'x' }, '<leader>cf', function()
	require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format' })

-- Diagnostics
local function diag_jump(next, severity)
	return function()
		vim.diagnostic.jump({
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		})
	end
end
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', '¨d', diag_jump(true), { desc = 'Next Diagnostic' })
map('n', 'åd', diag_jump(false), { desc = 'Prev Diagnostic' })
map('n', '¨e', diag_jump(true, 'ERROR'), { desc = 'Next Error' })
map('n', 'åe', diag_jump(false, 'ERROR'), { desc = 'Prev Error' })
map('n', '¨w', diag_jump(true, 'WARN'), { desc = 'Next Warning' })
map('n', 'åw', diag_jump(false, 'WARN'), { desc = 'Prev Warning' })

-- Inspect
map('n', '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })
map('n', '<leader>uI', function()
	vim.treesitter.inspect_tree()
	vim.api.nvim_input('I')
end, { desc = 'Inspect Treesitter Tree' })

-- Toggles
map('n', '<leader>us', function()
	vim.opt.spell = not vim.opt.spell:get()
end, { desc = 'Toggle Spelling' })
map('n', '<leader>uw', function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = 'Toggle Wrap' })
map('n', '<leader>uL', function()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = 'Toggle Relative Number' })
map('n', '<leader>ul', function()
	vim.opt.number = not vim.opt.number:get()
end, { desc = 'Toggle Line Numbers' })
map('n', '<leader>ud', function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle Diagnostics' })
map('n', '<leader>uh', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end, { desc = 'Toggle Inlay Hints' })
map('n', '<leader>ub', function()
	vim.opt.background = vim.opt.background:get() == 'dark' and 'light' or 'dark'
end, { desc = 'Toggle Background' })
map('n', '<leader>uc', function()
	local cl = vim.opt.conceallevel:get()
	vim.opt.conceallevel = cl == 0 and 2 or 0
end, { desc = 'Toggle Conceal Level' })

-- Tabs
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
map('n', '<leader><tab>¨', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>å', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })

-- Quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

-- Lazygit (built-in terminal)
if vim.fn.executable('lazygit') == 1 then
	map('n', '<leader>gg', function()
		vim.cmd('botright 20split | terminal lazygit')
		vim.cmd('startinsert')
	end, { desc = 'Lazygit' })
end

-- Keywordprg
map('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })

map('n', '<leader>t', function()
	Snacks.terminal()
end, { desc = 'Terminal' })
map({ 'n', 't' }, '<C-/>', function()
	Snacks.terminal()
end, { desc = 'Toggle Terminal' })

-- Window zoom
map('n', '<leader>wm', function()
	Snacks.toggle.zoom()
end, { desc = 'Toggle Zoom' })

-- Zen mode
map('n', '<leader>uz', function()
	Snacks.zen()
end, { desc = 'Toggle Zen Mode' })

-- Toggle treesitter highlight
map('n', '<leader>uT', function()
	if vim.b.ts_highlight then
		vim.treesitter.stop()
	else
		vim.treesitter.start()
	end
end, { desc = 'Toggle Treesitter Highlight' })

-- Dismiss notifications
map('n', '<leader>un', function()
	Snacks.notifier.hide()
end, { desc = 'Dismiss Notifications' })
