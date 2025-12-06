vim.diagnostic.config {
    float = {
        border = 'rounded',
    },
    underline = true,
    signs = true,
}

-- Configure diagnostic highlights to use undercurl
vim.cmd([[
  highlight DiagnosticUnderlineError guisp=#db4b4b gui=undercurl
  highlight DiagnosticUnderlineWarn guisp=#e0af68 gui=undercurl
  highlight DiagnosticUnderlineInfo guisp=#0db9d7 gui=undercurl
  highlight DiagnosticUnderlineHint guisp=#1abc9c gui=undercurl
]])
