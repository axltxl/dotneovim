--
-- layer: mason
-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
-- https://github.com/williamboman/mason.nvim
--

local core = require('core')
local keys = require('core.keys')
local utils = require('core.utils')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        -- base package manager for LSPs, linters, DAPs, formatters, etc.
        -- for every language, so ...
        { 'williamboman/mason.nvim' },
    }
end

-- set up configuration for this layer
function m.setup()
    -- base lsp package manager
    core.safe_require('mason', function(mason)
        -- mason configuration
        mason.setup()

        -- ***********************
        -- key mappings
        -- ***********************
        keys.map_leader_n(';lm', ':Mason<cr>', { desc = utils.desc("mason", "mason (package manager)") })
    end)
end

-- export the module
return m
