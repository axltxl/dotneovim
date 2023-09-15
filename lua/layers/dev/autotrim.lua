--
-- layer: autotrim
-- automatic file trimming upon saving
--

local core = require('core')


-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        { "cappyzawa/trim.nvim" },
    }
end

-- set up configuration for this layer
function m.setup()
    -- set up plugin
    core.safe_require('trim', function(trim)
        trim.setup {}
    end)

    -- automatically remove trailing
    -- whitespace upon saving a file
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = { "*" },
        command = [[%s/\s\+$//e]],
    })
end

-- export the module
return m
