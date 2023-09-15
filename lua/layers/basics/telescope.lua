--
-- layer: telescope
--


-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.2',
            dependencies = { 'nvim-lua/plenary.nvim' },
            lazy = true,
        }
    }
end

-- set up configuration for this layer
function m.setup()
end

-- export the module
return m
