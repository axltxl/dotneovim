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
        ---------------------------------------
        if not mason_registry.is_installed(lsp_pkg) then
            vim.cmd('MasonInstall ' .. lsp_pkg)
        end

        -- lsp server settings
        ------------------------------
        core.if_mod('lspconfig', function(lspconfig)
            local lsp_settings = {}

            -- ***********************************
            -- Enable autocompletion via nvim-cmp
            -- (needs autocompletion layer enabled)
            -- ***********************************
            -- Enable language server with the additional
            -- completion capabilities offered by nvim-cmp
            -- (this is for autocompletion)
            core.if_mod('cmp_nvim_lsp', function(cmp_nvim_lsp)
                lsp_settings['capabilities'] = cmp_nvim_lsp.default_capabilities()
            end)

            -- Finally set up that language server
            lspconfig.lua_ls.setup(lsp_settings)
        end)
    end)
end

-- export the module
return m
