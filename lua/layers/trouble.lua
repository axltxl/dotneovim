--
-- layer: trouble
-- diagnostics panel
--
local core  = require('core')
local keys  = require('core.keys')
local utils = require('core.utils')

-- we need this to export the module
local m     = {}

local function desc(msg)
    return utils.desc('trouble', msg)
end

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
            { desc = desc('file diagnostics') })

        -- show project-wide diagnostics (lsp-powered)
        keys.map_leader_n(';dw',
            function() trouble.open('workspace_diagnostics') end,
            { desc = desc('workspace diagnostics') })
        -- Overwrite some LSP key mappings
        -- some defaults come from the base lsp layer
        ----------------------------------
        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
       vim.api.nvim_create_autocmd('LspAttach', {
            group = 'UserLspConfig',
            callback = function(ev)
                local opts = { buffer = ev.buf }

                -- go to definition
                keys.map_n('<C-]>', function() trouble.open('lsp_definitions') end, opts)

                -- references
                keys.map_n('gr', function() trouble.open('lsp_references') end, opts)
            end
        })
    end)
end

-- export the module
return m
