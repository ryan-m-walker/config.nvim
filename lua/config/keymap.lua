-- Ctrl+C to copy entire buffer to system clipboard
vim.keymap.set('n', '<C-c>', function()
    vim.cmd 'normal! ggVG"+y'
    vim.notify('Buffer contents copied to clipboard!', vim.log.levels.INFO)
end, { desc = 'Copy entire buffer to clipboard' })

-- window nagivation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- split windows
vim.keymap.set('n', '<leader>w-', ':split<CR>', { noremap = true, silent = true, desc = '[W]indow split [H]orizontal' })
vim.keymap.set('n', '<leader>w\\', ':vsplit<CR>', { noremap = true, silent = true, desc = '[W]indow split [V]ertical' })

vim.keymap.set('n', '<leader>x', ':bd<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>X', ':bufdo bd<CR>', { noremap = true, silent = true })

-- terminal windows
vim.keymap.set('n', '<leader>t-', ':split term://zsh<CR>',
    { noremap = true, silent = true, desc = '[T]erminal split [H]orizontal' })
vim.keymap.set('n', '<leader>t\\', ':vsplit term://zsh<CR>',
    { noremap = true, silent = true, desc = '[T]erminal split [V]ertical' })

-- Don't confuse my coworkers
vim.keymap.set('n', '<leader>rl', ':set relativenumber!<CR>',
    { noremap = true, silent = true, desc = 'Toggle [R]elative [L]ine number' })


-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>vl', function()
    require('link-visitor').link_near_cursor()
end, { desc = "[V]isit [l]ink" })

local pretty_hover = require('pretty_hover')

-- LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
        map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('K', pretty_hover.hover, 'Hover Documentation')
        map('<leader>ld', vim.diagnostic.open_float, 'Show [L]ine [D]iagnostic')
    end,
})
