--
-- layer: trouble
-- diagnostics panel
--
local core = require('core')
local keys = require('core.keys')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    }
end

-- set up configuration for this layer
function m.setup()
    core.safe_require('trouble', function(trouble)
        trouble.setup {}

        -- toggle diagnostics panel
        keys.map_n('<C-j>', function() trouble.toggle() end)

        -- show document-wide diagnostics (lsp-powered)
        keys.map_leader_n(';dd',
            function() trouble.open('document_diagnostics') end,
            { desc = 'trouble > document diagnostics' })

        -- show project-wide diagnostics (lsp-powered)
        keys.map_leader_n(';dw',
            function() trouble.open('workspace_diagnostics') end,
            { desc = 'trouble > workspace diagnostics' })
    end)
end

-- export the module
return m
