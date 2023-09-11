--
-- layer: lang_lua
-- LSP, formatting et al. support for lua
--
local core = require('core')
local lsp_pkg = 'lua-language-server'

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return nil
end

-- set up configuration for this layer
function m.setup()
    core.if_mod('mason-registry', function(mason_registry)
        -- make sure lua lsp has been installed
        if not mason_registry.is_installed(lsp_pkg) then
            vim.cmd('MasonInstall ' .. lsp_pkg)
        end

        core.if_mod('lspconfig', function(lspconfig)
            -- lsp server settings
            local lsp_settings = {}

            -- Enable language server with the additional
            -- completion capabilities offered by nvim-cmp
            -- (this is for autocompletion)
            core.if_mod('plugins.conf.lsp.autocompletion', function(autocompletion)
                local nvim_cmp_capabilities = autocompletion.get_nvim_cmp_capabilities()
                if nvim_cmp_capabilities ~= nil then
                    lsp_settings['capabilities'] = nvim_cmp_capabilities
                end
            end)

            -- Finally set up that language server
            lspconfig.lua_ls.setup(lsp_settings)
        end)
    end)
end

-- export the module
return m
