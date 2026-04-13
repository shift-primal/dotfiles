-- Floating window utilities for CLI output (compile, upload, status, etc.)
local M = {}

local function strip_ansi(s)
	return s:gsub('\27%[[0-9;]*m', '')
end

local function split_lines(s)
	local t = {}
	for line in s:gmatch('[^\r\n]+') do
		t[#t + 1] = line
	end
	return t
end

-- Create a bottom-anchored floating window that starts small and grows.
-- Returns buf, win, opts (opts is mutable — passed back into append()).
function M.create()
	local width  = vim.o.columns
	local height = 5
	local buf    = vim.api.nvim_create_buf(false, true)
	local opts   = {
		relative = 'editor',
		width    = width,
		height   = height,
		row      = vim.o.lines - height - 2,
		col      = 0,
		style    = 'minimal',
		border   = 'rounded',
	}
	local win = vim.api.nvim_open_win(buf, true, opts)
	local function close()
		pcall(vim.api.nvim_win_close, win, false)
	end
	vim.keymap.set('n', '<CR>', close, { buffer = buf, silent = true, desc = 'Close output window' })
	vim.keymap.set('n', 'q',    close, { buffer = buf, silent = true, desc = 'Close output window' })
	return buf, win, opts
end

-- Append lines to buf, strip ANSI codes, and resize the window to fit.
-- `lines` may be a string or a list of strings.
function M.append(lines, buf, win, opts)
	if type(lines) == 'string' then lines = { lines } end

	local flat = {}
	for _, l in ipairs(lines) do
		vim.list_extend(flat, split_lines(l))
	end

	local cleaned = vim.tbl_map(strip_ansi, flat)
	vim.api.nvim_buf_set_lines(buf, -1, -1, false, cleaned)

	local count  = vim.api.nvim_buf_line_count(buf)
	opts.height  = math.min(count, vim.o.lines - 4)
	opts.row     = vim.o.lines - opts.height - 2
	vim.api.nvim_win_set_config(win, opts)
end

return M
