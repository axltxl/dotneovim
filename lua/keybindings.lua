--
-- key bindings section
--

local BINDINGOPTS = { noremap = true }

-- set leader key
vim.g.mapleader = ' '

-- a commodity function to map a key bind
-- in normal mode
function map_n(mnemonic, command, opts)
  if opts == nil then
    opts = BINDINGOPTS
  end
  vim.keymap.set('n', mnemonic, command, opts)
end

function map_leader_n(mnemonic, command, opts)
  map_n('<leader>' .. mnemonic, command, opts)
end

-- ***********************
-- window/tab management
-- ***********************

-- creation and deletion
map_leader_n('wv', ':vsplit<cr>')      -- split vertically
map_leader_n('ws', ':split<cr>')       -- split horizontally
map_leader_n('wd', ':q!<cr>')          -- remove split

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
local builtin = require('telescope.builtin')
local telescope = require('telescope')
map_leader_n('ff',
  function() builtin.find_files({
      hidden = true,
      no_ignore = true
    })
  end)
map_leader_n('fg', builtin.live_grep)
map_leader_n('fb', builtin.buffers)
map_leader_n('fh', builtin.help_tags)

-- project management
map_leader_n('pp', telescope.extensions.projects.projects, {})


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
-- CONTINUE HERE tomorrow
--lsp_opts = { buffer en
--map_leader_n('[', vim.lsp.bug.definition,
-- global mappings
