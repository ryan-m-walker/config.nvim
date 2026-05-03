-- Parser generator tool and an incremental parsing library
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local parsers = {
            'typescript',
            'tsx',
            'javascript',
            'html',
            'css',
            'styled',
            'json',
            'lua',
            'vim',
            'vimdoc',
            'query',
        }

        require('nvim-treesitter').setup()
        require('nvim-treesitter').install(parsers)

        vim.api.nvim_create_autocmd('FileType', {
            pattern = {
                'typescript',
                'typescriptreact',
                'javascript',
                'javascriptreact',
                'html',
                'css',
                'json',
                'lua',
                'vim',
                'vimdoc',
                'query',
            },
            callback = function()
                if pcall(vim.treesitter.start) then
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
