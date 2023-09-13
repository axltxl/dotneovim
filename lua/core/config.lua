--
-- configuration variables
-- These are used via get() and set() methods
-- as a nice way for layers to share data without
-- relying on obscure global variables
--

local core = require('core')
--
-- module itself
local m = {}

-- settings go in here
local settings = {}


-- get configuration variable
function m.get(k)
    if settings[k] == nil then
        core.log_error(k .. ': config setting not found')
    end
    return settings[k]
end

-- set configuration variable
function m.set(k, v)
    settings[k] = v
end

-- setting up some defaults
m.set('core.layer.unsafe_load', false) -- if true, loading layers won't be done with core.safe_require, but instead require()

return m
