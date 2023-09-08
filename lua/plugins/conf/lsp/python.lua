--
-- LSP configuration for python
--

local core = require("core")

core.safe_require('lspconfig', function(lspconfig)
    -- lsp server settings
    -- see: https://github.com/palantir/python-language-server
    -- see: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
    local lsp_server = 'pylsp'
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
    core.safe_require('plugins.conf.lsp.autocompletion', function(autocompletion)
        local nvim_cmp_capabilities = autocompletion.get_nvim_cmp_capabilities()
        if nvim_cmp_capabilities ~= nil then
            lsp_settings['capabilities'] = nvim_cmp_capabilities
        end
    end)

    -- Finally set up that language server
    lspconfig[lsp_server].setup(lsp_settings)
end)
