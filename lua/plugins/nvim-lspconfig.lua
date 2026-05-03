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
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      local eslint_on_attach = vim.lsp.config.eslint.on_attach
      vim.lsp.config('eslint', {
        on_attach = function(client, bufnr)
          if eslint_on_attach then
            eslint_on_attach(client, bufnr)
          end

          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'LspEslintFixAll',
          })
        end,
      })

      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
          },
        },
      })

      vim.lsp.config('graphql', {
        filetypes = { 'graphql' },
      })

      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'basic', -- 'off', 'basic', 'standard', 'strict'
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'openFilesOnly',
            },
          },
        },
      })

      vim.lsp.config('ruff', {
        on_attach = function(client, _)
          -- Disable hover in favor of pyright
          client.server_capabilities.hoverProvider = false
        end,
      })

      vim.lsp.config('gopls', {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      vim.lsp.config('clangd', {
        cmd = { 'clangd', '--background-index', '--clang-tidy', '--header-insertion=iwyu' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_markers = { 'compile_commands.json', '.clangd', '.git' },
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
      })

      vim.lsp.config('tsgo', {
        flags = {
          debounce_text_changes = 150,   -- Reduce LSP requests
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
      })

      vim.lsp.config('hls', {
        filetypes = { 'haskell', 'lhaskell', 'cabal' },
        root_markers = { 'hie.yaml', 'stack.yaml', 'cabal.project', '*.cabal', 'package.yaml', '.git' },
        settings = {
          haskell = {
            formattingProvider = 'ormolu',
          },
        },
      })

      vim.lsp.enable({
        'lua_ls',
        'eslint',
        'rust_analyzer',
        'graphql',
        'pyright',
        'ruff',
        'gopls',
        'clangd',
        'tsgo',
        'hls',
      })
    end,
  }
}
