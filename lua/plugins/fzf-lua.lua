-- Neovim fzf integration
-- https://github.com/ibhagwan/fzf-lua
return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('fzf-lua').setup({
                keymap = {
                    builtin = {
                        ["<C-u>"] = "preview-page-up",
                        ["<C-d>"] = "preview-page-down",
                    },
                },
            })

            local fzf = require('fzf-lua')

            -- Search keymaps
            vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = '[S]earch [S]elect FzfLua' })
            vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', fzf.registers, { desc = '[S]earch [R]egisters' })
            vim.keymap.set('n', '<leader>sm', fzf.marks, { desc = '[S]earch [M]arks' })
            vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })

            -- Git related searches
            vim.keymap.set('n', '<leader>gc', fzf.git_commits, { desc = '[G]it [c]ommits' })
            vim.keymap.set('n', '<leader>gC', fzf.git_bcommits, { desc = '[G]it buffer [C]ommits' })
            vim.keymap.set('n', '<leader>gb', fzf.git_branches, { desc = '[G]it [B]ranches' })
            vim.keymap.set('n', '<leader>gs', fzf.git_status, { desc = '[G]it [s]tatus' })
            vim.keymap.set('n', '<leader>gS', fzf.git_stash, { desc = '[G]it [S]tash' })

            -- LSP keymaps
            vim.keymap.set('n', '<leader>lr', fzf.lsp_references, { desc = '[L]SP [R]eferences' })
            vim.keymap.set('n', '<leader>ls', fzf.lsp_document_symbols, { desc = '[L]SP [S]ymbols' })
            vim.keymap.set('n', '<leader>ld', fzf.lsp_document_diagnostics, { desc = '[L]SP [D]iagnostics' })

            -- Special searches
            vim.keymap.set('n', '<leader>sb', fzf.blines, { desc = '[S]earch in [B]uffer' })
            vim.keymap.set('n', '<leader>s/', function()
                fzf.live_grep({
                    search = '',
                    grep_open_files = true,
                    prompt = 'Live Grep in Open Files> '
                })
            end, { desc = '[S]earch [/] in Open Files' })

            -- Search Neovim config files
            vim.keymap.set('n', '<leader>sn', function()
                fzf.files({ cwd = vim.fn.stdpath('config') })
            end, { desc = '[S]earch [N]eovim files' })
        end,
    }
}
