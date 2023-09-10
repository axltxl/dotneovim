--
-- layer: comment
-- toggle comments easily
--

local core = require("core")
local keys = require("core.keys")

-- we need this to export the module
local m = {}

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
    core.safe_require('Comment.api', function(comment)
        keys.map_leader_v(';', '<Plug>(comment_toggle_linewise_visual)')
        keys.map_leader_n(';;', '<Plug>(comment_toggle_linewise_current)')
    end)
end

-- export the module
return m
