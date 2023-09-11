--
-- layer: lang_python
-- LSP, formatting et al. support for python
--

local core = require('core')
local mason_pkg = 'python-lsp-server'
local lsp_server = 'pylsp'

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
        if not mason_registry.is_installed(mason_pkg) then
            vim.cmd('MasonInstall ' .. mason_pkg)
        end

        -- lsp server settings
        -- see: https://github.com/palantir/python-language-server
        -- see: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
        ------------------------------
        core.if_mod('lspconfig', function(lspconfig)
            local lsp_settings = {
                pylsp = {
                    plugins = {
                        -- static analysis (linting ...)
                        pylint = {
                            enabled = true
                        },

                        -- autocompletion
                        rope_completion = {
                            enabled = true
                        },

                        -- formatting
                        autopep8 = { enabled = false },
                        yapf = { enabled = true },
                    }
                }
            }

            -- Enable language server with the additional
            -- completion capabilities offered by nvim-cmp
            -- (this is for autocompletion)
            core.if_mod('cmp_nvim_lsp', function(cmp_nvim_lsp)
                lsp_settings['capabilities'] = cmp_nvim_lsp.default_capabilities()
            end)

            -- Finally set up that language server
            lspconfig[lsp_server].setup(lsp_settings)
        end)
    end)
end

-- export the module
return m
