-- Pickers for board, port, and library selection.
-- Uses vim.ui.select — Snacks hooks into this automatically as the UI backend.
local M = {}

local function cli_ok()
	if vim.fn.exepath('arduino-cli') == '' then
		vim.notify('arduino-cli not found in PATH', vim.log.levels.ERROR)
		return false
	end
	return true
end

-- Pick an Arduino board from `arduino-cli board listall`.
-- Calls `callback()` after the board is saved (used by M.gui()).
function M.select_board(state, callback)
	if not cli_ok() then return end

	local h = io.popen('arduino-cli board listall --format json')
	if not h then return end
	local raw = h:read('*a')
	h:close()

	local ok, data = pcall(vim.json.decode, raw)
	if not ok or not data or not data.boards then
		vim.notify('Arduino: failed to parse board list', vim.log.levels.ERROR)
		return
	end

	local items = {}
	for _, board in ipairs(data.boards) do
		if board.fqbn then
			items[#items + 1] = { label = (board.name or 'Unknown') .. '  ' .. board.fqbn, fqbn = board.fqbn }
		end
	end

	if #items == 0 then
		vim.notify('No boards found — install board packages with arduino-cli', vim.log.levels.WARN)
		return
	end

	vim.ui.select(items, {
		prompt      = 'Arduino Board',
		format_item = function(item) return item.label end,
	}, function(item)
		if not item then return end
		state.board = vim.trim(item.fqbn)
		vim.notify('Board: ' .. state.board)
		require('arduino.config').save(state)
		require('arduino.config').ensure_sketch_yaml(state)
		if callback then callback() end
	end)
end

-- Pick a port from `arduino-cli board list`.
function M.select_port(state)
	if not cli_ok() then return end

	local h = io.popen('arduino-cli board list')
	if not h then return end
	local raw = h:read('*a')
	h:close()

	local items = {}
	for line in raw:gmatch('[^\r\n]+') do
		local port = line:match('^(/dev/tty%S+)') or line:match('^(/dev/cu%S+)') or line:match('^(COM%d+)')
		if port then
			items[#items + 1] = { label = line, port = port }
		end
	end

	if #items == 0 then
		vim.notify('No connected ports found', vim.log.levels.WARN)
		return
	end

	vim.ui.select(items, {
		prompt      = 'Arduino Port',
		format_item = function(item) return item.label end,
	}, function(item)
		if not item then return end
		state.port = vim.trim(item.port)
		vim.notify('Port: ' .. state.port)
		require('arduino.config').save(state)
		require('arduino.config').ensure_sketch_yaml(state)
	end)
end

-- Run board picker then port picker sequentially (convenience GUI flow).
function M.gui(state)
	M.select_board(state, function()
		M.select_port(state)
	end)
end

-- ─── Library picker ──────────────────────────────────────────────────────────

local CACHE_FILE = vim.fn.stdpath('cache') .. '/arduino_libs.json'
local CACHE_TTL  = 7 * 24 * 3600 -- 7 days in seconds

local function load_cache()
	if vim.fn.filereadable(CACHE_FILE) == 0 then return nil end
	local stat = vim.uv.fs_stat(CACHE_FILE)
	if stat and (os.time() - stat.mtime.sec) > CACHE_TTL then return nil end
	local f = io.open(CACHE_FILE, 'r')
	if not f then return nil end
	local raw = f:read('*a')
	f:close()
	local ok, data = pcall(vim.json.decode, raw)
	if not ok or not data then return nil end
	-- Handle both formats: bare array or {libraries = [...]} object
	if data.libraries then return data.libraries end
	return data
end

local function save_cache(data)
	local f = io.open(CACHE_FILE, 'w')
	if not f then return end
	f:write(vim.json.encode(data))
	f:close()
end

local function get_installed()
	local set = {}
	local h = io.popen('arduino-cli lib list --format json')
	if not h then return set end
	local raw = h:read('*a')
	h:close()
	local ok, data = pcall(vim.json.decode, raw)
	if not ok or not data or not data.installed_libraries then return set end
	for _, entry in ipairs(data.installed_libraries) do
		local lib = entry.library
		local rel = entry.release
		if lib and lib.name then
			set[lib.name] = {
				installed  = lib.version,
				has_update = rel and rel.version and rel.version ~= lib.version,
			}
		end
	end
	return set
end

-- Browse and install Arduino libraries (7-day cached).
-- Typing "[installed]", "[outdated]", or "[uninstalled]" in the prompt filters by status.
function M.select_library()
	if not cli_ok() then return end

	local function open(libs, installed)
		local items = {}
		for _, lib in ipairs(libs) do
			local name = lib.name or ''
			local info = installed[name]
			local icon, tag
			if info then
				icon = info.has_update and '🔄 ' or '✅ '
				tag  = info.has_update and '[outdated]' or '[installed]'
			else
				icon = '   '
				tag  = '[uninstalled]'
			end
			items[#items + 1] = { label = icon .. name .. '  ' .. tag, name = name }
		end

		vim.ui.select(items, {
			prompt      = 'Arduino Libraries',
			format_item = function(item) return item.label end,
		}, function(item)
			if not item then return end
			vim.notify('Installing ' .. item.name .. '...')
			vim.fn.jobstart('arduino-cli lib install ' .. vim.fn.shellescape(item.name), {
				on_exit = function(_, code)
					if code == 0 then
						vim.notify('Installed: ' .. item.name)
					else
						vim.notify('Failed: ' .. item.name, vim.log.levels.ERROR)
					end
				end,
			})
		end)
	end

	local installed = get_installed()
	local cached    = load_cache()

	if cached then
		open(cached, installed)
		return
	end

	vim.notify('Fetching library list (this may take a moment)...')
	vim.fn.jobstart('arduino-cli lib search --format json', {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if not data or #data == 0 then return end
			local ok, result = pcall(vim.json.decode, table.concat(data, ''))
			if ok and result and result.libraries then
				save_cache(result.libraries)
				open(result.libraries, installed)
			else
				vim.notify('Failed to parse library list', vim.log.levels.ERROR)
			end
		end,
	})
end

return M
