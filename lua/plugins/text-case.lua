-- Change case of text use <ga>
-- https://github.com/johmsalas/text-case.nvim
return {
    "johmsalas/text-case.nvim",
    config = function()
        require("textcase").setup({})
    end,
    lazy = false,
}
