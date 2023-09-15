--
-- layer: yaml
-- YAML file support
--

local core       = require('core')
local config     = require('core.config')

-- we need this to export the module
local m          = {}
--
-- packages from mason required by this layer
local mason_pkgs = { 'yaml-language-server', 'yamlfmt' }
local lsp_server = 'yamlls' -- LSP server

-- list of plugins required by this layer
function m.get_plugins()
    return nil
end

-- Install all required packages in mason
local function mason_ensure_installed(mason_pkg)
    core.if_mod('mason-registry', function(mason_registry)
        if not mason_registry.is_installed(mason_pkg) then
            vim.cmd('MasonInstall ' .. mason_pkg)
        end
    end)
end

local function setup_efm()
    -- retrieve current efm settings from config API
    local efm_settings = config.get('lsp.efm.settings')

    -- set up yaml on efm settings
    ------------------------------------

    -- Make sure efm boots up on yaml buffers
    table.insert(efm_settings.filetypes, 'yaml')

    -- tool suite configuration for yaml
    --------------------------------------
    efm_settings.settings.languages.yaml = {
        {
            formatCommand = 'yamlfmt -quiet -in',
            formatStdin = true,
        }
    }

    -- Set updated efm settings back to config
    config.set('lsp.efm.settings', efm_settings)
end

-- set up configuration for this layer
function m.setup()
    -- yamlls does not format YAML files, so
    -- we'll have to use efm to setup yamlfmt
    ---------------------------------------
    setup_efm()
    --
    -- make sure the tool suite has been intalled
    -- by mason
    ---------------------------------------
    for _, mason_pkg in ipairs(mason_pkgs) do
        mason_ensure_installed(mason_pkg)
    end

    core.if_mod('lspconfig', function(lspconfig)
        local lsp_settings = {
            yaml = {
                -- List of supported schemas by this module
                -- see: https://shemastore.org
                schemas = {
                    -- GitHub workflow files
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                    -- AWS CloudFormation templates
                    ['https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json'] = 'cloudformation/*'
                }
            }
        }

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
