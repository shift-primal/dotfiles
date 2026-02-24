-- ts-comments.nvim — smarter comment toggling using treesitter
-- Correctly handles JSX ({/* */}), TSX, Vue template blocks, and embedded languages
-- Uses <leader>/ or gc (vim built-in comment operator)
return {
  "folke/ts-comments.nvim",
  opts = {
    -- lang = {
    --   -- Override comment strings per language:
    --   -- astro = "<!-- %s -->",
    --   -- svelte = "<!-- %s -->",
    -- },
  },
}
