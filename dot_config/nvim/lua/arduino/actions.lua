-- Core arduino-cli actions: check, upload, monitor, status, list ports
local M = {}

local function cli_ok()
	if vim.fn.exepath('arduino-cli') == '' then
		vim.notify('arduino-cli not found in PATH', vim.log.levels.ERROR)
		return false
	end
	return true
end

-- Show current board / port / baudrate in a floating window.
function M.status(state)
	local float = require('arduino.float')
	local buf, win, opts = float.create()
	float.append(string.format(
		'Board:    %s\nPort:     %s\nBaudrate: %s',
		state.board, state.port, state.baudrate
	), buf, win, opts)
end

-- Compile the current sketch and stream output to a floating window.
function M.check(state)
	if not cli_ok() then return end
	local float = require('arduino.float')
	local buf, win, opts = float.create()

	local cmd = 'arduino-cli compile --fqbn ' .. state.board .. ' ' .. vim.fn.expand('%:p:h')
	vim.fn.jobstart(cmd, {
		on_stdout = function(_, data)
			if data then float.append(data, buf, win, opts) end
		end,
		on_stderr = function(_, data)
			if not data then return end
			local errs = {}
			for _, l in ipairs(data) do
				if l:match('%S') then errs[#errs + 1] = 'Error: ' .. l end
			end
			if #errs > 0 then float.append(errs, buf, win, opts) end
		end,
		on_exit = function(_, code)
			float.append(code == 0 and '--- Check OK ---' or '--- Check Failed ---', buf, win, opts)
		end,
	})
end

-- Compile then upload; streams both stages to the same floating window.
function M.upload(state)
	if not cli_ok() then return end
	local float = require('arduino.float')
	local buf, win, opts = float.create()
	local dir = vim.fn.expand('%:p:h')

	local function err_lines(data)
		if not data or #data == 0 or not data[1]:match('%S') then return end
		float.append(vim.tbl_map(function(l) return 'Error: ' .. l end, data), buf, win, opts)
	end

	local function run_upload()
		local cmd = string.format(
			'arduino-cli upload -p %s --fqbn %s --verify %s',
			state.port, state.board, dir
		)
		vim.fn.jobstart(cmd, {
			on_stdout = function(_, data) if data then float.append(data, buf, win, opts) end end,
			on_stderr = function(_, data) err_lines(data) end,
			on_exit = function(_, code)
				if code == 0 then
					float.append('--- Upload Complete ---', buf, win, opts)
				else
					float.append({
						'--- Upload Failed ---',
						"Hint: ':InoList' shows available ports, ':InoSelectPort' to change",
					}, buf, win, opts)
				end
			end,
		})
	end

	vim.fn.jobstart('arduino-cli compile --fqbn ' .. state.board .. ' ' .. dir, {
		on_stdout = function(_, data) if data then float.append(data, buf, win, opts) end end,
		on_stderr = function(_, data) err_lines(data) end,
		on_exit = function(_, code)
			if code == 0 then
				float.append('--- Compilation OK — uploading... ---', buf, win, opts)
				run_upload()
			else
				float.append('--- Compilation Failed ---', buf, win, opts)
			end
		end,
	})
end

-- Open a centred terminal window running arduino-cli monitor.
function M.monitor(state)
	if not cli_ok() then return end

	local w   = math.floor(vim.o.columns * 0.8)
	local h   = math.floor(vim.o.lines   * 0.8)
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = 'editor',
		width    = w,
		height   = h,
		row      = math.floor((vim.o.lines   - h) / 2),
		col      = math.floor((vim.o.columns - w) / 2),
		style    = 'minimal',
		border   = 'rounded',
	})

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
		'Arduino Serial Monitor',
		string.rep('─', 30),
		'Board: ' .. state.board,
		'Port:  ' .. state.port,
		'',
		'Connecting...',
	})

	local term_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_win_set_buf(win, term_buf)
	vim.fn.termopen(
		string.format('arduino-cli monitor -p %s -b %s', state.port, state.board),
		{ cwd = vim.fn.expand('%:p:h') }
	)

	local function close_map(mode, key, rhs)
		vim.api.nvim_buf_set_keymap(term_buf, mode, key, rhs, { noremap = true, silent = true })
	end
	close_map('t', '<C-c>', '<C-\\><C-n>:bd!<CR>')
	close_map('n', '<C-c>', ':bd!<CR>')
	close_map('t', '<Esc>', '<C-\\><C-n>:bd!<CR>')
	close_map('n', '<Esc>', ':bd!<CR>')
	close_map('n', 'q',    ':bd!<CR>')

	vim.cmd('startinsert')
end

-- List connected Arduino boards/ports in a floating window.
function M.list_ports()
	if not cli_ok() then return end
	local float = require('arduino.float')
	local buf, win, opts = float.create()
	local h = io.popen('arduino-cli board list')
	if not h then return end
	float.append({ h:read('*a') }, buf, win, opts)
	h:close()
end

-- Insert Arduino boilerplate at the cursor position in the current buffer.
function M.insert_boilerplate()
	local lines = {
		'void setup() {',
		'\t// Runs once at boot',
		'\tSerial.begin(9600);',
		'}',
		'',
		'void loop() {',
		'\t// Runs repeatedly',
		'}',
	}
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, row, row, false, lines)
end

return M
