--
-- layer: todocomments
-- TODOs/FIXMEs management with trouble
-- extra dependencies:
-- * ripgrep
-- > brew install ripgrep
--

local core = require('core')
local keys = require('core.keys')
local utils = require('core.utils')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    }
end

-- set up configuration for this layer
function m.setup()
    core.safe_require('todo-comments', function(todo)
        -- set up plugins
        todo.setup {}

        -- Key mappings
        core.if_mod('trouble', function(trouble)
            -- use trouble to list all TODOs
            keys.map_leader_n(';df', function()
                trouble.open('todo')
            end, { desc = utils.desc('trouble', 'list TODOs') })
        end)
    end)
end

-- export the module
return m
