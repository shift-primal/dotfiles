local gh = function(x)
	return 'https://github.com/' .. x
end

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'nvim-treesitter' and kind == 'update' then
			if not ev.data.active then
				vim.cmd.packadd('nvim-treesitter')
			end
			vim.cmd('TSUpdate')
		end
	end,
})

vim.pack.add({
	-- Mini
	gh('nvim-mini/mini.nvim'),

	-- LSP
	gh('neovim/nvim-lspconfig'),

	-- Completion
	gh('saghen/blink.cmp'),

	-- Treesitter
	gh('nvim-treesitter/nvim-treesitter'),

	-- Formatting
	gh('stevearc/conform.nvim'),

	-- Snacks
	gh('folke/snacks.nvim'),
	gh('folke/lazydev.nvim'),

	-- Editor
	gh('windwp/nvim-autopairs'),
	gh('windwp/nvim-ts-autotag'),
	gh('cappyzawa/trim.nvim'),
	gh('lewis6991/gitsigns.nvim'),
	gh('MagicDuck/grug-far.nvim'),
	gh('folke/flash.nvim'),

	-- Diagnostics
	gh('rachartier/tiny-inline-diagnostic.nvim'),

	-- Colorscheme
	gh('eldritch-theme/eldritch.nvim'),

	-- UI
	gh('OXY2DEV/markview.nvim'),
	gh('nvim-lualine/lualine.nvim'),
	gh('folke/which-key.nvim'),
	gh('nvim-tree/nvim-web-devicons'),
	gh('folke/noice.nvim'),
	gh('MunifTanjim/nui.nvim'),
	gh('akinsho/bufferline.nvim'),
	gh('j-hui/fidget.nvim'),

	-- Utils
	gh('vyfor/cord.nvim'),
	gh('bngarren/checkmate.nvim'),
	gh('brenoprata10/nvim-highlight-colors'),
})

local function load(mod)
	local ok, err = pcall(require, mod)
	if not ok then
		vim.notify('Plugin config error: ' .. mod .. '\n' .. err, vim.log.levels.WARN)
	end
end

load('plugins.colorscheme')
load('plugins.lsp')
load('plugins.conform')
load('plugins.treesitter')
load('plugins.snacks')
load('plugins.ui')
load('plugins.editor')
load('plugins.mini')
load('plugins.completion')
load('plugins.diagnostics')
load('plugins.utils')
