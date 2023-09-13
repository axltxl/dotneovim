--
-- layer: dap
-- Debug Adapter Protocol implementation in neovim
--

local core = require('core')
local keys = require('core.keys')
local utils = require('core.utils')

-- we need this to export the module
local m = {}

local function desc(msg)
    return utils.desc('DAP', msg)
end

-- list of plugins required by this layer
function m.get_plugins()
    return {
        { 'mfussenegger/nvim-dap' },
        { 'rcarriga/nvim-dap-ui' },
    }
end

-- set up key mappings
----------------------
local function setup_keys()
    core.safe_require('dap', function(dap)
        -- toggle breakpoint
        keys.map_leader_n('db', function()
            dap.toggle_breakpoint()
        end, { desc = desc('toggle breakpoint') })

        -- start/continue
        keys.map_leader_n('d<space>', function()
            dap.continue()
        end, { desc = desc('start/continue') })

        -- step over
        keys.map_leader_n('d[', function()
            dap.step_over()
        end, { desc = desc('step over') })

        -- step into
        keys.map_leader_n('d]', function()
            dap.step_into()
        end, { desc = desc('step into') })

        -- terminate
        keys.map_leader_n('dt', function()
            dap.disconnect()
        end, { desc = desc('terminate session') })

        -- restart
        keys.map_leader_n('dr', function()
            dap.restart()
        end, { desc = desc('restart session') })
    end)
end

-- set up UI for DAP (dap-ui)
-----------------------------
local function setup_dapui()
    core.safe_require('dap', function(dap)
        core.safe_require('dapui', function(dapui)
            -- set up dapui plugin
            dapui.setup()

            -- use nvim-dap events to open and close the windows automatically
            -- source: https://github.com/rcarriga/nvim-dap-ui
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end)
    end)
end

-- set up configuration for this layer
function m.setup()
    setup_dapui()
    setup_keys()
end

-- export the module
return m
