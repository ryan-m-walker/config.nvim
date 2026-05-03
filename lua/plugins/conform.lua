-- Lightweight yet powerful formatter plugin for Neovim
-- https://github.com/stevearc/conform.nvim
return {
    {
        'stevearc/conform.nvim',
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = function()
            local function has_config(bufnr, names)
                return vim.fs.find(names, {
                    upward = true,
                    path = vim.api.nvim_buf_get_name(bufnr),
                })[1] ~= nil
            end

            local function js_formatter(bufnr)
                if has_config(bufnr, { 'biome.json', 'biome.jsonc' }) then
                    return { "biome" }
                end

                if has_config(bufnr, {
                        '.prettierrc',
                        '.prettierrc.json',
                        '.prettierrc.yml',
                        '.prettierrc.yaml',
                        '.prettierrc.json5',
                        '.prettierrc.js',
                        '.prettierrc.cjs',
                        '.prettierrc.mjs',
                        '.prettierrc.toml',
                        'prettier.config.js',
                        'prettier.config.cjs',
                        'prettier.config.mjs',
                }) then
                    return { "prettier" }
                end

                return {}
            end

            return {
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_format", "ruff_organize_imports" },
                    javascript = js_formatter,
                    javascriptreact = js_formatter,
                    typescript = js_formatter,
                    typescriptreact = js_formatter,
                    json = { "biome" },
                    jsonc = { "biome" },
                },
                format_on_save = function(bufnr)
                    if not has_config(bufnr, {
                            'biome.json',
                            'biome.jsonc',
                            '.prettierrc',
                            '.prettierrc.json',
                            '.prettierrc.yml',
                            '.prettierrc.yaml',
                            '.prettierrc.json5',
                            '.prettierrc.js',
                            '.prettierrc.cjs',
                            '.prettierrc.mjs',
                            '.prettierrc.toml',
                            'prettier.config.js',
                            'prettier.config.cjs',
                            'prettier.config.mjs',
                    }) then
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
            }
        end,
    }
}
