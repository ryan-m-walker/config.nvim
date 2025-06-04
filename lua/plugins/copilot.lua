return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
        require('copilot').setup {
            panel = {
                enabled = true,
                auto_refresh = true,
                keymap = {
                    jump_prev = '[[',
                    jump_next = ']]',
                    accept = '<CR>',
                    refresh = 'gr',
                    open = '<M-CR>',
                },
                layout = {
                    position = 'bottom',
                    ratio = 0.4,
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = '<M-l>',
                    accept_word = '<M-w>',
                    accept_line = '<M-]>',
                    next = '<M-]>',
                    prev = '<M-[>',
                    dismiss = '<C-]>',
                },
            },
            filetypes = {
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ['.'] = false,
            },
        }

        -- hide copilot suggestions when cmp menu is open
        -- to prevent suggestion duplicates
        local cmp_status_ok, cmp = pcall(require, 'cmp')
        if cmp_status_ok then
            cmp.event:on('menu_opened', function()
                vim.b.copilot_suggestion_hidden = true
            end)

            cmp.event:on('menu_closed', function()
                vim.b.copilot_suggestion_hidden = false
            end)
        end
    end,
}
