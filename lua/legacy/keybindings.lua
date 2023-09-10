--
-- key bindings section
--
-- ***********************
-- file management
-- ***********************

-- creation and deletion
map_leader_n('fn', ':new<cr>') -- new buffer on window
map_leader_n('fs', ':w<cr>')   -- save current buffer

-- nvim-tree
core.safe_require('nvim-tree', function(tree)
    map_leader_n('ft', ':NvimTreeToggle<cr>')   -- toggle nvim-tree
    map_leader_n('<tab>', ':NvimTreeFocus<cr>') -- toggle nvim-tree
    map_n('<C-b>', ':NvimTreeToggle<cr>')       -- toggle nvim-tree
end)

-- ***********************
-- telescope
-- ***********************
core.safe_require('telescope.builtin', function(builtin)
    map_leader_n('ff',
        function()
            builtin.find_files({
                hidden = true,
                no_ignore = true
            })
        end)
    map_leader_n('fg', builtin.live_grep)
    map_leader_n('fb', builtin.buffers)
    map_leader_n('fh', builtin.help_tags)
end)

-- project management
core.safe_require('telescope', function(telescope)
    map_leader_n('pp', telescope.extensions.projects.projects)
end)
--
-- ***********************
-- git
-- ***********************
core.safe_require('neogit', function(neogit)
    map_leader_n('gs', function() neogit.open() end)
end)

-- ***********************
-- text editing
-- ***********************
-- toggle comments
core.safe_require('Comment.api', function(comment)
    map_leader_v(';', '<Plug>(comment_toggle_blockwise_visual)')
    map_leader_n(';;', '<Plug>(comment_toggle_linewise_current)')
end)

-- format file (via lsp)
map_leader_n(';f', function() vim.lsp.buf.format { async = false } end)

-- ***********************
-- plugin management(lazy.nvim)
-- ***********************
map_leader_n(';l', ':Lazy<cr>') -- lazy menu

-- ***********************
-- commodities inspired by tpope
-- ***********************
map_n('[<space>', 'O<esc>')
map_n(']<space>', 'o<esc>')

-- ***********************
-- lsp
-- ***********************
-- mason
core.safe_require('mason', function(mason)
    map_leader_n(';m', ':Mason<cr>', { desc = "[lsp] Mason (package manager)" })
end)

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', 'gd', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        --
        -- displays information about the symbol under the cursor in a floating window
        map_n('gh', vim.lsp.buf.hover, opts)

        -- go to definition
        map_n('C-]', vim.lsp.buf.definition, opts)
    end
})
