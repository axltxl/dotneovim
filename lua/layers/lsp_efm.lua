--
-- layer: lsp_efm
-- efm-langserver: general purpose lsp server
-- ------------------------------------------
-- this layer can be used by other layers wanting
-- to use tools not directly supported in lspconfig.
-- To do that, a layer has to retrieve efm settings, like so:
-- -------------
-- local efm_settings = config.get('lsp.efm.settings')
-- -------------
-- Once that's done, a layer can then add its own settings
-- to it and submit then back to config, like so:
-- -------------
-- config.set('lsp.efm.settings', efm_settings)
-- -------------
-- This will be picked up by this layer as soon as all
-- layers have been enabled (via the CoreLayersDone event)
--

local core = require('core')
local config = require('core.config')
local mason_pkg = 'efm'

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return nil
end

-- set up configuration for this layer
function m.setup()
    -- Install efm via mason
    core.if_mod('mason', function(_)
        local mason_registry = require('mason-registry') -- it is safe at this point
        if not mason_registry.is_installed(mason_pkg) then
            vim.cmd('MasonInstall ' .. mason_pkg)
        end
    end)

    core.if_mod('lspconfig', function(lspconfig)
        --  Set up initial settings on config
        --  see: https://github.com/mattn/efm-langserver
        config.set('lsp.efm.settings', {
            init_options = {
                documentFormatting = true,
                documentRangeFormatting = true,
                hover = true,
                documentSymbol = true,
                codeAction = true,
                completion = true,
            },
            settings = {
                rootMarkers = { './git' },
                languages = {}
            },
            filetypes = {}
        })

        -- Set up efm-langserver in lspconfig
        -- This cannot be done immediately, since other layers
        -- may want to chip in and use efm for their LSP tool suite.
        -- Therefore, once the CoreLayersDone event has been triggered
        -- this function will be invoked, and will take care of setting
        -- up efm-langserver in lspconfig
        core.create_autocmd('CoreLayersDone',
            function()
                local lsp_settings = config.get('lsp.efm.settings')
                print(lsp_settings.settings.filetypes)

                -- Enable language server with the additional
                -- completion capabilities offered by nvim-cmp
                -- (this is for autocompletion)
                core.if_mod('cmp_nvim_lsp', function(cmp_nvim_lsp)
                    lsp_settings['capabilities'] = cmp_nvim_lsp.default_capabilities()
                end)

                -- Finally set up that language server
                lspconfig.efm.setup(lsp_settings)
            end
        )
    end)
end

-- export the module
return m
