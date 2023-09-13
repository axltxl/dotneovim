--
-- layer: lsp
-- LSP configuration
-- set up mason and tie it with nvim-lspconfig
-- for a nice LSP support on nvim
--

local core = require('core')
local keys = require('core.keys')
local utils = require('core.utils')

local function desc(msg)
    return utils.desc('LSP', msg)
end

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        -- this will instruct our mason what LSPs
        -- to install
        { 'williamboman/mason-lspconfig.nvim' },

        -- .. and this one will configure every LSP
        -- individually
        { 'neovim/nvim-lspconfig' },
    }
end

-- Key mappings
-- ***********************
local function setup_keymappings()
    -- Format file using local lsp
    keys.map_leader_n(';f', function()
        vim.lsp.buf.format { async = false }
    end, { desc = desc('format file') })

    -- Mappings for Diagnostics
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    keys.map_n('gd', vim.diagnostic.open_float, { desc = desc('popup diagnostic') })
    keys.map_n('[d', vim.diagnostic.goto_prev, { desc = desc('go to previous diagnostic') })
    keys.map_n(']d', vim.diagnostic.goto_next, {desc = desc('go to next diagnostic')})
    -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            --
            -- displays information about the symbol under the cursor in a floating window
            keys.map_n('gh', vim.lsp.buf.hover, opts)

            -- go to definition
            keys.map_n('<C-]>', vim.lsp.buf.definition, opts)
        end
    })
end

-- set up configuration for this layer
function m.setup()
    -- set log level on lspconfig
    vim.lsp.set_log_level("debug")

    core.if_mod('mason', function(_)
        -- this is where we tell mason what LSPs
        -- do we want to be installed
        core.safe_require('mason-lspconfig', function(mason_lspconfig)
            mason_lspconfig.setup({})
        end)
    end)

    -- set up key mappings
    setup_keymappings()
end

-- export the module
return m
