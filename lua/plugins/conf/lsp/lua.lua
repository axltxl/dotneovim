--
-- LSP configuration for lua
--

local core = require("core")
core.safe_require('lspconfig', function(lspconfig)
    lspconfig.lua_ls.setup {}
end)
