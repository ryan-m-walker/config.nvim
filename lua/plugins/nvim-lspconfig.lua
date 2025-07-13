-- Provides configurations for LSP clients
-- https://github.com/neovim/nvim-lspconfig
return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'folke/lazydev.nvim',
                ft = 'lua',
                opts = {
                    library = {
                        {
                            path = '${3rd}/luv/library',
                            words = { 'vim%.uv' }
                        },
                    },
                },
            },

            {
                'yioneko/nvim-vtsls',
                dependencies = { 'nvim-lua/plenary.nvim' },
                ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
            },
        },
        config = function()
            local lspconfig = require('lspconfig')

            -- lua
            lspconfig.lua_ls.setup {}

            -- typescript
            lspconfig.vtsls.setup {
                settings = {
                    vtsls = {
                        experimental = {
                            maxInlayHintLength = 50,
                        },
                        tsserver = {
                            maxTsServerMemory = 8192, -- 8GB of memory
                        },
                    },
                    typescript = {
                        tsserver = {
                            maxTsServerMemory = 8192, -- 8GB of memory
                        },
                    },
                },
            }

            -- tailwind
            lspconfig.tailwindcss.setup {}

            -- eslint
            lspconfig.eslint.setup {
                on_attach = function(_, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            }

            lspconfig.relay_lsp.setup {
                auto_start_compiler = false,
            }

            -- rust
            lspconfig.rust_analyzer.setup {
                settings = {
                    ['rust-analyzer'] = {
                        checkOnSave = {
                            command = 'clippy',
                        },
                    },
                },
            }

            lspconfig.graphql.setup {
                filetypes = { 'graphql' },
            }
        end,
    }
}
