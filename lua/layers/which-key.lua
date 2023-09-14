--
-- layer: which-key
--

local core = require('core')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        { 'folke/which-key.nvim' }
    }
end

-- set up configuration for this layer
function m.setup()
    core.safe_require('which-key', function(which_key)
        vim.o.timeout    = true
        vim.o.timeoutlen = 500
        which_key.setup {
            window = {
                border = "single", --
            }
        }

        -- Main prefix descriptions go in here
        --------------------------------------
        which_key.register({
            ["<leader>"] = {
                p = { "+project" }, -- project management
                f = { "+file" }, -- file management
                d = { "+debug" }, -- debugger (DAP)
                g = { "+git" }, -- git repository management
                t = { "+tab" }, -- tab management
                w = { "+window" }, -- window management
                [";"] = { -- editor settings
                    name = "+nvim",
                    c = { "+colorscheme" }, -- color scheme
                    d = { "+diagnostics" } -- diagnostics management
                }
            }
        })
    end)
end

-- export the module
return m
