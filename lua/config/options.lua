-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- https://vale.rocks/posts/neovim
-- set relative number when in normal mode
vim.api.nvim_create_autocmd(
    { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
    { pattern = "*", command = "if &nu && mode() != 'i' | set rnu | endif", }
)

-- set no relative number when in insert mode
vim.api.nvim_create_autocmd(
    { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
    { pattern = "*", command = "if &nu | set nornu | endif", }
)

-- spacing
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.showmode = false

-- mouse
vim.opt.mouse = 'a'

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'

-- cursor
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- clipboard
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)
