-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
-- https://github.com/nvimtools/none-ls.nvim
return {
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        depends = { "davidmh/cspell.nvim" },
        opts = function(_, opts)
            local cspell = require("cspell")
            opts.sources = opts.sources or {}
            table.insert(
                opts.sources,
                cspell.diagnostics.with({
                    diagnostics_postprocess = function(diagnostic)
                        diagnostic.severity = vim.diagnostic.severity.HINT
                    end,
                })
            )
            table.insert(opts.sources, cspell.code_actions)
        end,
    },
}
