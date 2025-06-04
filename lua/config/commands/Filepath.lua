local function get_project_root()
    local current_dir = vim.fn.expand '%:p:h'
    local git_root = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(current_dir) .. ' rev-parse --show-toplevel')[1]

    if vim.v.shell_error == 0 and git_root then
        return git_root
    end

    return vim.fn.getcwd()
end

local function get_relative_filepath()
    local full_path = vim.fn.expand '%:p'
    local root = get_project_root()
    local relative_path = full_path:sub(#root + 2) -- +2 to account for trailing slash
    return relative_path
end

vim.api.nvim_create_user_command('Filepath', function()
    local filepath = get_relative_filepath()
    vim.fn.setreg('+', filepath)
    vim.notify('Filepath copied to clipboard: ' .. filepath, vim.log.levels.INFO)
end, {})
