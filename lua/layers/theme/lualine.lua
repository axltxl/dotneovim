--
-- layer: lualine
-- powerline
--

local core = require("core")

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        { 'nvim-lualine/lualine.nvim' },
    }
end

-- set up configuration for this layer
function m.setup()
    core.safe_require('lualine', function(lualine)
        lualine.setup {}
    end)
end

-- export the module
return m
