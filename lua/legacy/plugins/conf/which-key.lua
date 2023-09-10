--
-- which-key conf
--


local core = require('core')
core.safe_require('which-key', function(which_key)
    vim.o.timeout    = true
    vim.o.timeoutlen = 500
    which_key.setup {
        window = {
            border = "single", --
        }
    }
end)
