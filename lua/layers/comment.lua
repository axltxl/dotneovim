--
-- layer: comment
-- toggle comments easily
--

local core = require("core")
local keys = require("core.keys")
local utils = require('core.utils')

-- we need this to export the module
local m = {}

local function desc(msg)
    return utils.desc('comment', msg)
end

-- list of plugins required by this layer
function m.get_plugins()
    return {
        { 'numToStr/Comment.nvim' },
    }
end

-- set up configuration for this layer
function m.setup()
    -- set up plugin
    core.safe_require('Comment', function(comment)
        comment.setup({
            mappings = {
                basic = false,
                extra = false,
            },
        })
    end)

    -- key mappings
    core.safe_require('Comment.api', function(_)
        keys.map_leader_v(';', '<Plug>(comment_toggle_linewise_visual)', {desc = desc('toggle comment (visual)')})
        keys.map_leader_n(';;', '<Plug>(comment_toggle_linewise_current)', {desc = desc('toggle comment (line)')})
    end)
end

-- export the module
return m
