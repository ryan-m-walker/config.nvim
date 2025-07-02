-- Plugin that automatically changes the editor appearance based on system settings
-- https://github.com/f-person/auto-dark-mode.nvim
return {
    "f-person/auto-dark-mode.nvim",
    opts = {
        set_dark_mode = function()
            vim.cmd.colorscheme 'monokai-pro'
        end,
        set_light_mode = function()
            vim.cmd.colorscheme 'dawnfox'
        end,
        update_interval = 3000,
        fallback = "dark"
    }
}
