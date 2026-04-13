require('blink.cmp').setup({
	fuzzy = {
		implementation = 'prefer_rust_with_warning',

		max_typos = function(keyword)
			return math.floor(#keyword / 4)
		end,

		frecency = {
			enabled = true,
			path = vim.fn.stdpath('state') .. '/blink/cmp/frecency.dat',
			unsafe_no_lock = false,
		},
		use_proximity = true,

		sorts = {
			'score',
			'sort_text',
		},
	},

	appearance = {
		nerd_font_variant = 'mono',
	},

	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},

	completion = {
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		menu = {
			draw = {
				treesitter = { 'lsp' },
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		ghost_text = {
			enabled = true,
		},
	},

	signature = {
		enabled = true,
		window = { border = 'rounded' },
	},

	cmdline = {
		enabled = true,
		keymap = {
			preset = 'cmdline',
			['<Right>'] = false,
			['<Left>'] = false,
		},
		completion = {
			list = { selection = { preselect = false } },
			menu = {
				auto_show = function()
					return vim.fn.getcmdtype() == ':'
				end,
			},
			ghost_text = { enabled = true },
		},
	},

	keymap = {
		preset = 'enter',
		['<C-y>'] = { 'select_and_accept' },
	},
})
