-- Read the FQBN from sketch.yaml at LSP startup time.
-- arduino/config.lua calls ensure_sketch_yaml() before vim.lsp.enable(),
-- so sketch.yaml is always up to date when this runs.
local function get_fqbn()
	local f = io.open('sketch.yaml', 'r')
	if not f then
		return 'arduino:avr:uno'
	end
	local content = f:read('*a')
	f:close()
	local fqbn = content:match('default_fqbn:%s*(.+)')
	return fqbn and vim.trim(fqbn) or 'arduino:avr:uno'
end

return {
	cmd = {
		'arduino-language-server',
		'-cli',
		'arduino-cli',
		'-cli-config',
		vim.fn.expand('$HOME/.arduino15/arduino-cli.yaml'),
		'-clangd',
		vim.fn.exepath('clangd') ~= '' and vim.fn.exepath('clangd') or '/usr/bin/clangd',
		'-fqbn',
		get_fqbn(),
	},
	filetypes = { 'arduino' },
	root_markers = { 'sketch.yaml', '*.ino', '.git' },
}
