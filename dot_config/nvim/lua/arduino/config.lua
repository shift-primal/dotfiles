-- Manages .arduino_config.lua (project-local board/port/baud) and sketch.yaml
local M = {}

local CONFIG_FILE = '.arduino_config.lua'

-- Load config from .arduino_config.lua in the cwd into `state`.
-- Creates the file with defaults if it doesn't exist.
function M.load(state)
	if vim.fn.filereadable(CONFIG_FILE) == 0 then
		M.save(state)
		return
	end
	local chunk = loadfile(CONFIG_FILE)
	if not chunk then return end
	local ok, settings = pcall(chunk)
	if ok and type(settings) == 'table' then
		state.board    = settings.board    or state.board
		state.port     = settings.port     or state.port
		state.baudrate = settings.baudrate or state.baudrate
	end
end

-- Persist current state to .arduino_config.lua.
function M.save(state)
	local f = io.open(CONFIG_FILE, 'w')
	if not f then
		vim.notify('Arduino: cannot write ' .. CONFIG_FILE, vim.log.levels.ERROR)
		return
	end
	f:write(string.format(
		'return { board = %q, port = %q, baudrate = %q }\n',
		state.board, state.port, tostring(state.baudrate)
	))
	f:close()
end

-- Write (or overwrite) sketch.yaml so arduino-language-server picks up the
-- correct FQBN without needing an explicit -fqbn flag.
-- Only runs when a .ino file exists in the cwd.
function M.ensure_sketch_yaml(state)
	if #vim.fn.glob('*.ino', false, true) == 0 then return end
	local f = io.open('sketch.yaml', 'w')
	if not f then return end
	f:write('default_fqbn: ' .. state.board .. '\n')
	f:write('default_port: ' .. state.port .. '\n')
	f:close()
end

return M
