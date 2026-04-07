-- We intentionally do NOT call require("Arduino-Nvim.lsp").setup() here.
-- Letting the plugin own lspconfig.setup() causes two servers to race:
--   1. our call  → correct FQBN, wrong root (getcwd)
--   2. lspconfig's default FileType autocmd → no FQBN, correct root (root_pattern)
--
-- Instead we own the single lspconfig.setup() call with:
--   - root_pattern("*.ino")  so root_dir is always the sketch folder
--   - on_new_config(cfg, root_dir) reads .arduino_config.lua from that
--     root_dir (not CWD), so the FQBN is correct regardless of where nvim
--     was launched from
--
-- require("Arduino-Nvim") is still loaded for keymaps, commands, board/port
-- management, and the floating-window compile/upload/monitor UI.

return {
	"yuukiflow/arduino-nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"neovim/nvim-lspconfig",
	},
	ft = "arduino",
	init = function()
		vim.treesitter.language.register("cpp", "arduino")
	end,
	config = function()
		local lspconfig = require("lspconfig")
		local util = require("lspconfig.util")

		lspconfig.arduino_language_server.setup({
			filetypes = { "arduino" },
			root_dir = util.root_pattern("*.ino"),
			on_new_config = function(config, root_dir)
				-- Read board from .arduino_config.lua written by :InoSelectBoard.
				-- Falls back to arduino:avr:uno if no config exists yet.
				local board = "arduino:avr:uno"
				local loader = loadfile(root_dir .. "/.arduino_config.lua")
				if loader then
					local ok, cfg = pcall(loader)
					if ok and type(cfg) == "table" and type(cfg.board) == "string" and cfg.board ~= "" then
						board = cfg.board
					end
				end

				config.cmd = {
					"arduino-language-server",
					"-clangd",
					vim.fn.exepath("clangd"),
					"-cli",
					vim.fn.exepath("arduino-cli"),
					"-cli-config",
					vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
					"-fqbn",
					board,
				}
			end,
		})

		-- Ensure the module (keymaps, commands) is active for every arduino buffer.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "arduino",
			callback = function()
				require("Arduino-Nvim") -- cached after first load, no-op subsequently
				vim.opt_local.shiftwidth = 4
				vim.opt_local.tabstop = 4
				vim.opt_local.expandtab = true
			end,
		})
	end,
}
