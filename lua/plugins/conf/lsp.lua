--
-- LSP configuration goes in here

local core = require("core")

-- base lsp package manager
-- local ok, mason = pcall(require, 'mason')

core.safe_require('mason', function(mason)
    -- mason configuration
    mason.setup()

    -- this is where we tell mason what LSPs
    -- do we want to be installed
    core.safe_require('mason-lspconfig', function(mason_lspconfig)
        mason_lspconfig.setup({
            -- lua
            ensure_installed = { "lua_ls" }
        })
    end)

    -- .. and this one will configure every LSP
    -- ***********************************************
    core.safe_require('lspconfig', function(lspconfig)
        -- lua
        lspconfig.lua_ls.setup {}
    end)
end)

--
-- automatically format file upon saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function()
        vim.lsp.buf.format { async = false }
    end,
})
