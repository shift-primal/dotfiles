vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local buf = ev.buf
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
		end

		map('n', '<leader>cl', function()
			Snacks.picker.lsp_config()
		end, 'Lsp Info')
		map('n', 'gd', vim.lsp.buf.definition, 'Goto Definition')
		map('n', 'gr', vim.lsp.buf.references, 'References')
		map('n', 'gI', vim.lsp.buf.implementation, 'Goto Implementation')
		map('n', 'gy', vim.lsp.buf.type_definition, 'Goto T[y]pe Definition')
		map('n', 'gD', vim.lsp.buf.declaration, 'Goto Declaration')
		map('n', 'K', vim.lsp.buf.hover, 'Hover')
		map('n', 'gK', vim.lsp.buf.signature_help, 'Signature Help')
		map('i', '<c-k>', vim.lsp.buf.signature_help, 'Signature Help')
		map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
		map({ 'n', 'x' }, '<leader>cc', vim.lsp.codelens.run, 'Run Codelens')
		map('n', '<leader>cC', vim.lsp.codelens.refresh, 'Refresh & Display Codelens')
		map('n', '<leader>cR', function()
			Snacks.rename.rename_file()
		end, 'Rename File')
		map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename')
		map({ 'n', 'x' }, '<leader>cA', function()
			vim.lsp.buf.code_action({ context = { only = { 'source' } } })
		end, 'Source Action')
		map('n', '<leader>co', function()
			vim.lsp.buf.code_action({
				context = { only = { 'source.organizeImports' } },
				apply = true,
			})
		end, 'Organize Imports')
		map('n', ']]', function()
			Snacks.words.jump(vim.v.count1)
		end, 'Next Reference')
		map('n', '[[', function()
			Snacks.words.jump(-vim.v.count1)
		end, 'Prev Reference')
		map('n', '<a-n>', function()
			Snacks.words.jump(vim.v.count1, true)
		end, 'Next Reference')
		map('n', '<a-p>', function()
			Snacks.words.jump(-vim.v.count1, true)
		end, 'Prev Reference')
	end,
})

vim.lsp.enable({
	'clangd',
	'lua_ls',
	'marksman',
	'pyright',
	'tailwindcss',
	'vtsls',
})
