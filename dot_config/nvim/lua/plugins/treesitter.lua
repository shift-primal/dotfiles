require('nvim-treesitter').setup()

-- Enable treesitter highlighting and indent for every buffer that has a parser
vim.api.nvim_create_autocmd('FileType', {
	callback = function(ev)
		local buf = ev.buf
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > 500 * 1024 then
			return
		end
		pcall(vim.treesitter.start, buf)
		vim.bo[buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
	end,
})
