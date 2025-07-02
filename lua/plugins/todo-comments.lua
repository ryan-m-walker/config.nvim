-- Highlight and search for todo comments
-- https://github.com/folke/todo-comments.nvim
return {
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false }
    },
}
