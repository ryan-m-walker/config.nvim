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
                python = { "ruff_format", "ruff_organize_imports" },
                javascript = { "biome" },
                javascriptreact = { "biome" },
                typescript = { "biome" },
                typescriptreact = { "biome" },
                json = { "biome" },
                jsonc = { "biome" },
            },
            format_on_save = function(bufnr)
                -- Only use biome formatter if a biome config exists in the project
                local has_biome = vim.fs.find({ 'biome.json', 'biome.jsonc' }, {
                    upward = true,
                    path = vim.api.nvim_buf_get_name(bufnr),
                })[1]

                if not has_biome then
                    local ft = vim.bo[bufnr].filetype
                    if ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
                        return false
                    end
                end

                return {
                    timeout_ms = 200,
                    lsp_fallback = true,
                }
            end,
        },
    }
}
