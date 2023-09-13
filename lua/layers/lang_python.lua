--
-- layer: lang_python
-- LSP, formatting et al. support for python
--

local core = require('core')
local config = require('core.config')
local lsp_server = 'pyright'

-- packages from mason required by this layer
local mason_packages = {
    'pyright', -- linter
    'ruff',    -- another linter, built in rust
    'mypy',    -- static analysis
    'black',   -- formatter
    'debugpy'  -- DAP (debugging)
}

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        { 'mfussenegger/nvim-dap-python', ft = 'python' } -- DAP support for python
    }
end

-- Install all required packages in mason
local function mason_ensure_installed(mason_pkg)
    core.if_mod('mason-registry', function(mason_registry)
        if not mason_registry.is_installed(mason_pkg) then
            vim.cmd('MasonInstall ' .. mason_pkg)
        end
    end)
end

-- Set up python tools in efm
-- These are properly caught by lsp_efm layer
-- as soon as the CoreLayersDone event has been triggered
---------------------------------------------------------
local function setup_efm()
    -- retrieve current efm settings from config API
    local efm_settings = config.get('lsp.efm.settings')

    -- set up python on efm settings
    ------------------------------------

    -- Make sure efm boots up on python buffers
    table.insert(efm_settings.filetypes, 'python')

    -- tool suite configuration for python
    --------------------------------------
    efm_settings.settings.languages.python = {
        -- black: my formatter of choice
        {
            formatCommand = 'black --no-color -q -',
            formatStdin = true
        },
        -- mypy: static analysis
        {
            lintCommand = 'mypy --show-column-numbers',
            lintSource = 'efm/mypy',
            lintStdin = false,
            lintFormats = {
                '%f:%l:%c: %trror: %m',
                '%f:%l:%c: %tarning: %m',
                '%f:%l:%c: %tote: %m',
            }
        },
        -- ruff: fast linter
        {
            lintCommand = 'ruff --quiet',
            lintSource  = 'efm/ruff'
        }
    }

    -- Set updated efm settings back to config
    config.set('lsp.efm.settings', efm_settings)
end

local function setup_lsp()
    core.if_mod('mason-registry', function(_)
        -- Only pyright is properly supported
        -- by nvim-lspconfig, but we can set up
        -- efm-langserver to run ruff, mypy and black
        -- to have a complete tool suite for python ;)
        ---------------------------------------
        setup_efm()

        -- make sure the tool suite has been intalled
        -- by mason
        ---------------------------------------
        for _, mason_pkg in ipairs(mason_packages) do
            mason_ensure_installed(mason_pkg)
        end


        -- lsp server settings
        ---------------------------------------
        core.if_mod('lspconfig', function(lspconfig)
            -- Enable language server with the additional
            -- completion capabilities offered by nvim-cmp
            -- (this is for autocompletion)
            local lsp_settings = {}
            core.if_mod('cmp_nvim_lsp', function(cmp_nvim_lsp)
                lsp_settings['capabilities'] = cmp_nvim_lsp.default_capabilities()
            end)
            --
            -- -- Finally set up that language server
            lspconfig[lsp_server].setup(lsp_settings)
        end)
    end)
end

-- Set up DAP adapter for python
local function setup_dap()
    core.if_mod('dap', function(_)
        core.safe_require('dap-python', function(dap_python)
            -- Set up DAP adapter
            -- we're using debugpy virtualenv for this
            dap_python.setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
        end)
    end)
end

-- set up configuration for this layer
function m.setup()
    -- lsp setup
    setup_lsp()

    -- debugging
    setup_dap()
end

-- export the module
return m
