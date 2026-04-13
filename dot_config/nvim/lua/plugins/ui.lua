-- Colorscheme

require('catppuccin').setup({
	flavour = 'mocha',
	transparent_background = true,
	float = { transparent = true, solid = false },

	integrations = {
		treesitter = true,
		telescope = { enabled = true },
		mini = { enabled = true },
		native_lsp = {
			enabled = true,
			underlines = {
				errors = { 'undercurl' },
				hints = { 'undercurl' },
				warnings = { 'undercurl' },
				information = { 'undercurl' },
			},
		},
	},
})

vim.cmd.colorscheme('catppuccin')

-- Noice
require('noice').setup({
	lsp = {
		override = {
			['vim.lsp.util.convert_input_to_markdown_lines'] = true,
			['vim.lsp.util.stylize_markdown'] = true,
		},
		-- blink.cmp handles signature help; disable noice's duplicate
		signature = { enabled = false },
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
	routes = {
		{
			filter = {
				event = 'msg_show',
				any = {
					{ find = 'lines yanked' },
					{ find = 'more lines' },
					{ find = 'fewer lines' },
					{ find = 'line less' },
				},
			},
			opts = { skip = true },
		},
		{
			filter = { event = 'msg_show', kind = 'hit_enter' },
			opts = { skip = true },
		},
	},
})

-- Bufferline

require('bufferline').setup({
	options = {
		always_show_bufferline = true,
		diagnostics = 'nvim_lsp',
		diagnostics_indicator = function(_, _, diag)
			local icons = { error = ' ', warning = ' ' }
			return (diag.error and icons.error .. diag.error or '')
				.. (diag.warning and icons.warning .. diag.warning or '')
		end,
		offsets = {
			{ filetype = 'snacks_layout_box' },
		},
		separator_style = 'slant',
	},
	highlights = {
		-- slant separators: fg must match fill bg so the triangle blends in
		fill = { bg = '#1e1e2e' },
		separator = { fg = '#1e1e2e' },
		separator_selected = { fg = '#1e1e2e' },
		separator_visible = { fg = '#1e1e2e' },
	},
})

-- Lualine

require('lualine').setup({
	options = {
		theme = 'catppuccin-mocha',
		globalstatus = true,
		section_separators = { left = '', right = '' },
		component_separators = { left = '', right = '' },
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { { 'filename', path = 1 } },
		lualine_x = {
			{
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients == 0 then
						return ''
					end
					return ' '
						.. table.concat(
							vim.tbl_map(function(c)
								return c.name
							end, clients),
							', '
						)
				end,
				color = { fg = '#a6adc8' },
			},
			'encoding',
			'fileformat',
			'filetype',
		},
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},
})

-- Alpha (Startup dashboard)

local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
alpha.setup(dashboard.config)

-- Fidget

require('fidget').setup({
	progress = {
		suppress_on_insert = true,
		ignore_done_already = true,
	},
	notification = {
		window = { winblend = 0 },
	},
})
