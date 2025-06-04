return {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'

        dashboard.section.header.val = {
            [[                               _                ]],
            [[  ___     ___    ___   __  __ /\_\    ___ ___   ]],
            [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\ ]],
            [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
            [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
            [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        }

        dashboard.section.buttons.val = {
            dashboard.button('f', '  Find file', ':Telescope find_files <CR>'),
            dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
            dashboard.button('r', '  Recently used files', ':Telescope oldfiles <CR>'),
            dashboard.button('t', '  Find text', ':Telescope live_grep <CR>'),
            dashboard.button('c', '  Configuration', ':e $MYVIMRC <CR>'),
            dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
        }

        dashboard.config.opts.noautocmd = true
        -- Set header padding
        dashboard.config.layout = {
            { type = 'padding', val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
            dashboard.section.header,
            { type = 'padding', val = 5 },
            dashboard.section.buttons,
            { type = 'padding', val = 2 },
            dashboard.section.footer,
        }

        alpha.setup(dashboard.config)
    end,
}
