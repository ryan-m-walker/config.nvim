return {
    {
        'trevorhauter/gitportal.nvim',
        config = function()
            require('gitportal').setup {
                always_include_current_line = true,
            }
        end,
    },
}
