--
-- layer: treesitter
-- treesitter for syntax highlighting et al.
--

local core = require('core')
local keys = require('core.keys')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return { 'nvim-treesitter/nvim-treesitter' }
end

-- set up configuration for this layer
function m.setup()
    core.safe_require('nvim-treesitter.configs', function(treesitter)
        treesitter.setup {

            --basic settings
            ensure_installed = 'all',
            sync_installed = true,
            ignore_install = { "" },

            -- highlighting settings
            highlight = {
                enable = true,
                disable = { "" },
                additional_vim_regex_highlighting = true,
            },

            -- automatic indentation settings
            indent = { enable = true, disable = { "" } },
        }

        -- set up key mappings
        core.if_mod('telescope.builtin', function(telescope)
            keys.map_leader_n('fo', function() telescope.treesitter() end, { desc = "symbols" })
        end)
    end)
end

-- export the module
return m
