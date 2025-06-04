return {
    {
        'loctvl842/monokai-pro.nvim',
        priority = 1000,
        config = function()
            require('monokai-pro').setup {
                transparent_background = true,
                terminal_colors = true,
                devicons = true,
                filter = 'pro', -- classic | octagon | pro | machine | ristretto | spectrum
                background_clear = {
                    'float_win',
                    'toggleterm',
                    'telescope',
                    'which-key',
                    'nvim-tree',
                    'bufferline',
                },
                inc_search = 'background', -- underline | background
                italic_comments = true,
                plugins = {
                    bufferline = {
                        underline_selected = false,
                        underline_visible = false,
                    },
                    indent_blankline = {
                        context_highlight = 'default', -- default | pro
                    },
                },
            }

            vim.cmd.colorscheme 'monokai-pro'
        end,
    },
}
