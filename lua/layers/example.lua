--
-- layer: example
-- example layer
--


-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return nil
end

-- set up configuration for this layer
function m.setup()
end

-- export the module
return m
