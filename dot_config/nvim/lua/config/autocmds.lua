-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable document_color to prevent assertion crash when conform.nvim applies text edits
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.lsp.document_color.enable(false, { bufnr = args.buf })
	end,
})

-- Disable spell-checking in markdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.spell = false
	end,
})

-- blink.cmp's documentation popup uses filetype "blink-cmp-documentation" for its
-- (markdown) LSP hover content. Treesitter doesn't know that filetype, so snacks.image
-- never attaches to render the `![img](data:image/svg+xml;base64,...)` icon previews
-- inside it. Registering it as markdown fixes both the attach check and the parser lookup.
vim.treesitter.language.register("markdown", "blink-cmp-documentation")
