vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

-- Configure diagnostic floating window to have a rounded border
vim.diagnostic.config {
    float = {
        border = 'rounded',
        style = 'minimal',
    },
}
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
