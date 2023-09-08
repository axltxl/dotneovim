--
-- LSP configuration goes in here

local core = require("core")

-- set log level on lspconfig
vim.lsp.set_log_level("debug")

-- LSP server list
-- -------------------
local lsp_servers = {
    -- lua
    "lua_ls",

    --python
    "pylsp",
}

-- base lsp package manager
core.safe_require('mason', function(mason)
    -- mason configuration
    mason.setup()

    -- this is where we tell mason what LSPs
    -- do we want to be installed
    core.safe_require('mason-lspconfig', function(mason_lspconfig)
        mason_lspconfig.setup({
            ensure_installed = lsp_servers
        })
    end)
end)

--
-- automatically format file upon saving a file
--
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function()
        vim.lsp.buf.format { async = false }
    end,
})
