-- Autopairs / autotags
require('nvim-ts-autotag').setup()
require('nvim-autopairs').setup({
	check_ts = true,
})

-- Trim (strip whitespace)
require('trim').setup()
