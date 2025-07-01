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

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
