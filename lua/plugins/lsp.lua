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
            -- LSP keymaps
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                    map('K', vim.lsp.buf.hover, 'Hover Documentation')
                end,
            })

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
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            }

            -- relay
            lspconfig.relay_lsp.setup {}

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
        end,
    }
}
