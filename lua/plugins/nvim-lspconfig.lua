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

            -- typescript -- using tsgo
            -- lspconfig.vtsls.setup {
            --     settings = {
            --         vtsls = {
            --             experimental = {
            --                 maxInlayHintLength = 50,
            --             },
            --             tsserver = {
            --                 maxTsServerMemory = 8192, -- 8GB of memory
            --             },
            --         },
            --         typescript = {
            --             tsserver = {
            --                 maxTsServerMemory = 8192, -- 8GB of memory
            --             },
            --         },
            --     },
            -- }

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

            -- Go
            lspconfig.gopls.setup {
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            }

            -- C/C++
            lspconfig.clangd.setup {
                cmd = { 'clangd', '--background-index', '--clang-tidy', '--header-insertion=iwyu' },
                filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
                root_dir = lspconfig.util.root_pattern('compile_commands.json', '.clangd', '.git'),
                init_options = {
                    clangdFileStatus = true,
                    usePlaceholders = true,
                    completeUnimported = true,
                    semanticHighlighting = true,
                },
                settings = {
                    clangd = {
                        fallbackFlags = { '-std=c17' },
                    },
                },
            }

            local configs = require "lspconfig.configs"
            if not configs.tsgo then
                configs.tsgo = {
                    default_config = {
                        cmd = { "tsgo", "--lsp", "--stdio" },
                        filetypes = {
                            "javascript",
                            "javascriptreact",
                            "javascript.jsx",
                            "typescript",
                            "typescriptreact",
                            "typescript.tsx",
                        },
                        root_dir = lspconfig.util.root_pattern(
                            "tsconfig.json",
                            "jsconfig.json",
                            "package.json",
                            ".git",
                            "tsconfig.base.json"
                        ),
                        settings = {},
                    },
                }
            end

            -- Optimized tsgo setup with performance settings
            lspconfig.tsgo.setup {
                flags = {
                    debounce_text_changes = 150, -- Reduce LSP requests
                    allow_incremental_sync = true, -- Use incremental sync
                },
                on_attach = function(client, bufnr)
                    -- Disable semantic tokens to reduce load
                    client.server_capabilities.semanticTokensProvider = nil

                    -- Optionally disable some features that cause freezing
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
                settings = {
                    -- Add any tsgo-specific performance settings here
                    completions = {
                        completeFunctionCalls = false, -- Reduce completion overhead
                    },
                },
            }
        end,
    }
}
