-- Tiny plugin to enhance Neovim's native comments
-- folke/ts-comments.nvim
return {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has 'nvim-0.10.0' == 1,
}
