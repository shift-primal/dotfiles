-- Arduino integration entry point.
-- Called from the FileType 'arduino' autocmd:  require('arduino').setup()
--
-- State is a single table shared across the session so all submodules see the
-- same board/port/baudrate without needing to re-read the config file.

local M = {}

M.state = {
	board    = 'arduino:avr:uno',
	port     = '/dev/ttyACM0',
	baudrate = '115200',
}

local _initialized = false

function M.setup()
	local cfg = require('arduino.config')

	-- Load persisted config and ensure sketch.yaml once per session.
	if not _initialized then
		_initialized = true
		cfg.load(M.state)
		cfg.ensure_sketch_yaml(M.state)
		-- Explicitly set the LSP config with the correct FQBN before enabling.
		-- nvim-lspconfig ships its own lsp/arduino_language_server.lua which wins
		-- the runtimepath race and omits all flags; vim.lsp.config() overrides it.
		vim.lsp.config('arduino_language_server', {
			cmd = {
				'arduino-language-server',
				'-cli',        'arduino-cli',
				'-cli-config', vim.fn.expand('$HOME/.arduino15/arduino-cli.yaml'),
				'-clangd',     vim.fn.exepath('clangd') ~= '' and vim.fn.exepath('clangd') or '/usr/bin/clangd',
				'-fqbn',       M.state.board,
			},
			filetypes    = { 'arduino' },
			root_markers = { 'sketch.yaml', '*.ino', '.git' },
		})
		vim.lsp.enable('arduino_language_server')
	end

	-- Register commands + buffer-local keymaps for this buffer.
	require('arduino.commands').setup(M.state)
end

return M
