-- Lightweight yet powerful formatter plugin for Neovim
-- https://github.com/stevearc/conform.nvim
return {
    {
        'stevearc/conform.nvim',
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
            },
            format_on_save = function(bufnr)
                -- Skip formatting for TS/JS files since ESLint handles them
                local ft = vim.bo[bufnr].filetype
                if ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
                    return false
                end
                return {
                    timeout_ms = 500,
                    lsp_fallback = true,
                }
            end,
        },
    }
}
