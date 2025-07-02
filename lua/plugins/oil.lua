-- File explorer
-- https://github.com/stevearc/oil.nvim
return {
    'stevearc/oil.nvim',
    opts = {
        view_options = {
            show_hidden = true,
        }
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
        { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    },
    lazy = false,
}
