--
-- layer: lsp.json
-- support for JSON files
--

local core = require('core')

-- we need this to export the module
local m = {}

-- packages from mason required by this layer
local mason_pkg  = 'json-lsp'
local lsp_server = 'jsonls' -- LSP server

--
-- list of plugins required by this layer
function m.get_plugins()
    return nil
end

-- set up configuration for this layer
function m.setup()
    -- Install all required packages in mason
    core.if_mod('mason-registry', function(mason_registry)
        if not mason_registry.is_installed(mason_pkg) then
            vim.cmd('MasonInstall ' .. mason_pkg)
        end
    end)

    core.if_mod('lspconfig', function(lspconfig)
        local lsp_settings = {}
        core.if_mod('cmp_nvim_lsp', function(cmp_nvim_lsp)
            lsp_settings['capabilities'] = cmp_nvim_lsp.default_capabilities()
        end)
        --
        -- -- Finally set up that language server
        lspconfig[lsp_server].setup(lsp_settings)
    end)
end

-- export the module
return m
