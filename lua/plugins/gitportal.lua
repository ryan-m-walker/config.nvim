-- Open your current file in GitHub
-- https://github.com/trevorhauter/gitportal.nvim
return {
    {
        'trevorhauter/gitportal.nvim',
        config = function()
            local gitportal = require('gitportal')

            gitportal.setup {
                always_include_current_line = true,
            }

            vim.keymap.set("n", "<leader>gp", gitportal.open_file_in_browser)
            vim.keymap.set("v", "<leader>gp", gitportal.open_file_in_browser)
        end,
    },
}
