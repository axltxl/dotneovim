--
-- layer: autopairs
-- automatic pairing
--

local core = require('core')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        { "windwp/nvim-autopairs" },
    }
end

-- set up configuration for this layer
function m.setup()
    core.safe_require('nvim-autopairs', function(mod)
        mod.setup {}
    end)
end

-- export the module
return m
