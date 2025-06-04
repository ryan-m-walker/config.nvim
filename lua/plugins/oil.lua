return {
    'stevearc/oil.nvim',
    opts = {
        -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
        default_file_explorer = true,
        -- Id is automatically added at the beginning, and name at the end
        -- See :help oil-columns
        columns = {
            'icon',
            'permissions',
            'size',
            'mtime',
        },
        -- Buffer-local options to use for oil buffers
        buf_options = {
            buflisted = false,
            bufhidden = 'hide',
        },
        -- Window-local options to use for oil buffers
        win_options = {
            wrap = false,
            signcolumn = 'no',
            cursorcolumn = false,
            foldcolumn = '0',
            spell = false,
            list = false,
            conceallevel = 3,
            concealcursor = 'nvic',
        },
        -- Send deleted files to the trash instead of permanently deleting them
        delete_to_trash = false,
        -- Skip the confirmation popup for simple operations
        skip_confirm_for_simple_edits = false,
        -- Change this to customize the command used when deleting to trash
        -- trash_command = 'trash-put',
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        prompt_save_on_select_new_entry = true,
        -- Oil will automatically delete hidden buffers after this delay
        -- You can set the delay to false to disable cleanup entirely
        -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
        cleanup_delay_ms = 2000,
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        keymaps = {
            ['g?'] = 'actions.show_help',
            ['<CR>'] = 'actions.select',
            ['<C-s>'] = 'actions.select_vsplit',
            ['<C-h>'] = 'actions.select_split',
            ['<C-t>'] = 'actions.select_tab',
            ['<C-p>'] = 'actions.preview',
            ['<C-c>'] = 'actions.close',
            ['<C-l>'] = 'actions.refresh',
            ['-'] = 'actions.parent',
            ['_'] = 'actions.open_cwd',
            ['`'] = 'actions.cd',
            ['~'] = 'actions.tcd',
            ['gs'] = 'actions.change_sort',
            ['gx'] = 'actions.open_external',
            ['g.'] = 'actions.toggle_hidden',
        },
        -- Set to false to disable all of the above keymaps
        use_default_keymaps = true,
        view_options = {
            -- Show files and directories that start with "."
            show_hidden = true,
            -- This function defines what is considered a "hidden" file
            is_hidden_file = function(name, bufnr)
                return vim.startswith(name, '.')
            end,
            -- This function defines what will never be shown, even when `show_hidden` is set
            is_always_hidden = function(name, bufnr)
                return false
            end,
            sort = {
                -- sort order can be "asc" or "desc"
                -- see :help oil-columns to see which columns are sortable
                { 'type', 'asc' },
                { 'name', 'asc' },
            },
        },
        -- Configuration for the floating window in oil.open_float
        float = {
            -- Padding around the floating window
            padding = 2,
            max_width = 0,
            max_height = 0,
            border = 'rounded',
            win_options = {
                winblend = 0,
            },
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            override = function(conf)
                return conf
            end,
        },
    },
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
        { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    },
}
