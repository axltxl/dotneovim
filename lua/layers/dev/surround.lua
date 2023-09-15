--
-- layer: surround
-- automatic surrounding
--

local core = require('core')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
        }
    }
end

-- set up configuration for this layer
function m.setup()
    core.safe_require('nvim-surround', function(mod)
        mod.setup {}
    end)
end

-- export the module
return m
