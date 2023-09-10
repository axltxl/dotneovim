--
-- layer: foundation
-- the essentials go in here
--

local keys = require('core.keys')

-- tab size
local tabsize = 4

-- leader key
local leader = ' '

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return nil
end

-- set up configuration for this layer
function m.setup()

    -- disable netrw at the very start of your init.lua
    -- (this is required by nvim-tree, see: plugins.lua)
    -- FIXME: move me
    vim.g.loaded_netrw       = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.showcmd          = true
    vim.opt.autoindent       = true    -- automatic indentation
    vim.opt.expandtab        = true    -- spaces for indentation
    vim.opt.tabstop          = tabsize -- how many spaces?
    vim.opt.list             = true
    vim.opt.listchars        = { lead = '.', eol = '↵', space = '.', trail = '.', extends = '<', precedes = '>', }
    vim.opt.shiftwidth       = tabsize --  << >>
    vim.opt.swapfile         = false   -- disable swap files and swap files by default
    vim.opt.number           = true    -- display line numbers
    vim.opt.wrap             = false   -- disable wordwrap
    vim.opt.mouse            = ""      -- disable mouse
    vim.opt.termguicolors    = true    -- enable terminal colors

    -- automatically remove trailing
    -- whitespace upon saving a file
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = { "*" },
        command = [[%s/\s\+$//e]],
    })

    -- set leader key
    vim.g.mapleader = leader

    -- ***********************
    -- Bad habits
    -- ***********************
    -- disable backspace
    keys.map_n('<BS>', '<Nop>')
    keys.map_v('<BS>', '<Nop>')

    -- ***********************
    -- editor general management
    -- ***********************
    keys.map_leader_n(';q', ':wqall!<cr>') -- quit neovim (autosave every buffer)

    -- ***********************
    -- plugin management(lazy.nvim)
    -- ***********************
    keys.map_leader_n(';l', ':Lazy<cr>') -- lazy menu

    -- ***********************
    -- commodities inspired by tpope
    -- ***********************
    keys.map_n('[<space>', 'O<esc>')
    keys.map_n(']<space>', 'o<esc>')
end

-- export the module
return m
