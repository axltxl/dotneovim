--
-- key bindings section
--

local core = require("core")
local DEFAULT_BINDINGOPTS = { noremap = true }

-- set leader key
vim.g.mapleader = ' '


-- a commodity function to map a key bind
function map(mode, keys, command, opts)
    if opts == nil then
        opts = DEFAULT_BINDINGOPTS
    else
        opts['noremap'] = true
    end
    vim.keymap.set(mode, keys, command, opts)
end

-- in normal mode
function map_n(mnemonic, command, opts)
    map('n', mnemonic, command, opts)
end

function map_leader_n(mnemonic, command, opts)
    map_n('<leader>' .. mnemonic, command, opts)
end

-- visual mode
function map_v(mnemonic, command, opts)
    map('v', mnemonic, command, opts)
end

function map_leader_v(mnemonic, command, opts)
    map_v('<leader>' .. mnemonic, command, opts)
end

-- insert mode
function map_i(mnemonic, command, opts)
    map('i', mnemonic, command, opts)
end

-- ***********************
-- Bad habits
-- ***********************
-- disable backspace
-- FIXME: implement me
map_n('<BS>', '<Nop>')
map_v('<BS>', '<Nop>')

-- ***********************
-- editor general management
-- ***********************
map_leader_n(';q', ':wqall!<cr>') -- quit neovim (autosave every buffer)


-- ***********************
-- window/tab management
-- ***********************

-- creation and deletion
map_leader_n('wv', ':vsplit<cr>', { desc = "split vertically" })  -- split vertically
map_leader_n('ws', ':split<cr>', { desc = "split horizontally" }) -- split horizontally
map_leader_n('wd', ':q!<cr>', { desc = "close current window" })  -- remove split

-- navigation
map_leader_n('wk', ':wincmd k<cr>') -- up
map_leader_n('wj', ':wincmd j<cr>') -- down
map_leader_n('wl', ':wincmd l<cr>') -- right
map_leader_n('wh', ':wincmd h<cr>') -- left

-- tab management
map_leader_n('tn', ':tabnew<cr>')      -- new tab
map_leader_n('td', ':tabclose<cr>')    -- close tab
map_leader_n('tl', ':tabnext<cr>')     -- go to next tab
map_leader_n('th', ':tabprevious<cr>') -- go to previous tab

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
