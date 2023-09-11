--
-- layer: lsp
-- LSP configuration
-- set up mason and tie it with nvim-lspconfig
-- for a nice LSP support on nvim
--

local core = require('core')
local keys = require('core.keys')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        -- base lsp package manager, there's an LSP
        -- for every language, so ...
        { 'williamboman/mason.nvim' },
        --
        -- this will instruct our mason what LSPs
        -- to install
        { 'williamboman/mason-lspconfig.nvim' },
        --
        -- .. and this one will configure every LSP
        -- individually
        { 'neovim/nvim-lspconfig' },
    }
end

-- set up configuration for this layer
function m.setup()
    -- set log level on lspconfig
    vim.lsp.set_log_level("debug")

    -- base lsp package manager
    core.safe_require('mason', function(mason)
        -- mason configuration
        mason.setup()

        -- this is where we tell mason what LSPs
        -- do we want to be installed
        core.safe_require('mason-lspconfig', function(mason_lspconfig)
            mason_lspconfig.setup()
        end)
    end)

    -- ***********************
    -- key mappings
    -- ***********************
    core.safe_require('mason', function(mason)
        keys.map_leader_n(';lm', ':Mason<cr>', { desc = "[lsp] Mason (package manager)" })
    end)

    -- Mappings for Diagnostics
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    keys.map_n('gd', vim.diagnostic.open_float)
    keys.map_n('[d', vim.diagnostic.goto_prev)
    keys.map_n(']d', vim.diagnostic.goto_next)
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
            keys.map_n('C-]', vim.lsp.buf.definition, opts)
        end
    })
end

-- export the module
return m
