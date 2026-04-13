-- Registers :Ino* user commands (once) and buffer-local <leader>a* keymaps (per buffer).
local M = {}

local _commands_registered = false

-- Register global :Ino* commands. Called only on the first Arduino buffer.
local function register_commands(state)
	if _commands_registered then
		return
	end
	_commands_registered = true

	local actions = require('arduino.actions')
	local picker = require('arduino.picker')
	local cfg = require('arduino.config')

	local cmds = {
		InoUpload = {
			fn = function(_)
				actions.upload(state)
			end,
			nargs = 0,
		},
		InoCheck = {
			fn = function(_)
				actions.check(state)
			end,
			nargs = 0,
		},
		InoStatus = {
			fn = function(_)
				actions.status(state)
			end,
			nargs = 0,
		},
		InoBoilerplate = {
			fn = function(_)
				actions.insert_boilerplate()
			end,
			nargs = 0,
		},
		InoMonitor = {
			fn = function(_)
				actions.monitor(state)
			end,
			nargs = 0,
		},
		InoList = {
			fn = function(_)
				actions.list_ports()
			end,
			nargs = 0,
		},
		InoSelectBoard = {
			fn = function(_)
				picker.select_board(state)
			end,
			nargs = 0,
		},
		InoSelectPort = {
			fn = function(_)
				picker.select_port(state)
			end,
			nargs = 0,
		},
		InoLib = {
			fn = function(_)
				picker.select_library()
			end,
			nargs = 0,
		},
		InoGUI = {
			fn = function(_)
				picker.gui(state)
			end,
			nargs = 0,
		},
		InoSetBaud = {
			fn = function(o)
				state.baudrate = vim.trim(o.args)
				vim.notify('Baudrate: ' .. state.baudrate)
				cfg.save(state)
			end,
			nargs = 1,
		},
	}

	for name, def in pairs(cmds) do
		vim.api.nvim_create_user_command(name, def.fn, { nargs = def.nargs })
	end
end

-- Register buffer-local <leader>a* keymaps. Called for every Arduino buffer.
local function register_keymaps(state)
	local map = function(key, fn, desc)
		vim.keymap.set('n', key, fn, { buffer = true, silent = true, desc = desc })
	end

	local actions = require('arduino.actions')
	local picker = require('arduino.picker')

	map('<leader>au', function()
		actions.upload(state)
	end, 'Upload')
	map('<leader>ac', function()
		actions.check(state)
	end, 'Check / Compile')
	map('<leader>an', function()
		actions.insert_boilerplate()
	end, 'Insert Boilerplate')
	map('<leader>as', function()
		actions.status(state)
	end, 'Status')
	map('<leader>am', function()
		actions.monitor(state)
	end, 'Serial Monitor')
	map('<leader>ab', function()
		picker.select_board(state)
	end, 'Select Board')
	map('<leader>ap', function()
		picker.select_port(state)
	end, 'Select Port')
	map('<leader>al', function()
		picker.select_library()
	end, 'Library Manager')
	map('<leader>ag', function()
		picker.gui(state)
	end, 'Setup GUI (board → port)')
end

-- Entry point called by arduino/init.lua on every Arduino FileType event.
function M.setup(state)
	register_commands(state)
	register_keymaps(state)
end

return M
