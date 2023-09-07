--
-- key bindings section
--

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
map_leader_n(';q', ':wqall!<cr>')      -- quit neovim (autosave every buffer)


-- ***********************
-- window/tab management
-- ***********************

-- creation and deletion
map_leader_n('wv', ':vsplit<cr>', {desc = "split vertically"})     -- split vertically
map_leader_n('ws', ':split<cr>',  {desc= "split horizontally"})    -- split horizontally
map_leader_n('wd', ':q!<cr>',     {desc = "close current window"}) -- remove split

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
map_leader_n('fn', ':new<cr>')           -- new buffer on window
map_leader_n('fs', ':w<cr>')             -- save current buffer
map_leader_n('ft',   ':NvimTreeToggle<cr>')  -- toggle nvim-tree
map_leader_n('<tab>', ':NvimTreeFocus<cr>') -- toggle nvim-tree
map_n       ('<C-b>', ':NvimTreeToggle<cr>') -- toggle nvim-tree

-- ***********************
-- telescope
-- ***********************
local ok, builtin = pcall(require, 'telescope.builtin')
if ok then
  map_leader_n('ff',
    function() builtin.find_files({
        hidden = true,
        no_ignore = true
      })
    end)
  map_leader_n('fg', builtin.live_grep)
  map_leader_n('fb', builtin.buffers)
  map_leader_n('fh', builtin.help_tags)
end

-- project management
local ok, telescope = pcall(require, 'telescope')
if ok then
  map_leader_n('pp', telescope.extensions.projects.projects)
end

-- ***********************
-- text editing
-- ***********************
local ok, comment = pcall(require, 'Comment.api')
 if ok then
  map_leader_v(';', '<Plug>(comment_toggle_blockwise_visual)')
  map_leader_n(';;', '<Plug>(comment_toggle_linewise_current)')
 end

-- ***********************
-- plugin management(lazy.nvim)
-- ***********************
map_leader_n('ll', ':Lazy<cr>')    -- lazy menu

-- ***********************
-- commodities inspired by tpope
-- ***********************
map_n('[<space>', 'O<esc>')
map_n(']<space>', 'o<esc>')

-- ***********************
-- lsp
-- ***********************
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
     -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      map_n('gh', vim.lsp.buf.hover, opts)
    end
})
