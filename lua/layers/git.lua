--
-- layer: git
-- git repositories management
--

local core = require('core')
local keys = require('core.keys')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        {
            "NeogitOrg/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim", -- required
            }
        }
    }
end

-- set up configuration for this layer
function m.setup()
    core.safe_require('neogit', function(neogit)
        -- plugin setup
        neogit.setup {}

        -- key mappings
        keys.map_leader_n('gs', function() neogit.open() end)
    end)
end

-- export the module
return m
