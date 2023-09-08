--
-- LSP configuration for python
--

local core = require("core")
core.safe_require('lspconfig', function(lspconfig)
    -- python
    -------------------
    lspconfig.pylsp.setup {
        pylsp = {
            plugins = {
                autopep8 = {
                    enabled = true
                }
            }
        }
    }
end)
