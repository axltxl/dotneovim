--
-- layer: tab
-- tab management
--

local keys = require('core.keys')
local utils = require('core.utils')

local function desc(msg)
    return utils.desc('tab', msg)
end

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return nil
end

-- set up configuration for this layer
function m.setup()
    -- tab management
    keys.map_leader_n('tn', ':tabnew<cr>', { desc = desc('new') })       -- new tab
    keys.map_leader_n('td', ':tabclose<cr>', { desc = desc('close') })   -- close tab
    keys.map_leader_n('tl', ':tabnext<cr>', { desc = desc('go to next') }) -- go to next tab
    keys.map_leader_n('th', ':tabprevious<cr>', {desc = desc('go to previous')})                          -- go to previous tab
end

-- export the module
return m
