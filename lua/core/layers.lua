--
-- Layers engine
-- Configuration is added as a series
-- of "layers", one of top of the other
-- so that they are self contained and coupling
-- is avoided
--

core = require('core')

-- we need this to export the module
local m = {}

-- internal list of layer modules go in here
-- see lua/layers directory
local layermods = {}

-- Bootstrap plugin manager (lazy)
function plugin_manager_setup()
    -- install lazy.nvim (plugin manager) automatically
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)
end

-- install the plugins themselves
function plugin_install()
    local plugins = {}
    for i, lm in ipairs(layermods) do
        local lplugins = lm.get_plugins()
        if lplugins ~= nil then
            for i, lplug in ipairs(lplugins) do
                table.insert(plugins, lplug)
            end
        end
    end
    require("lazy").setup(plugins)
end

-- enable a layer
-- each layer is loaded as a module, and it's expected
-- to have the following functions available
-- get_plugins() -> returns a table of plugins alla lazy, otherwise nil if the layer doesn't need plugins to be installed
-- setup() -> this will be invoked when boot() is invoked, doesn't have to return
function m.enable(layers)
    for i, layer in ipairs(layers) do
        core.safe_require('layers.' .. layer, function(l)
            table.insert(layermods, l)
            core.log_info("layer enabled: " .. layer)
        end)
    end
end

--
-- Start the engines
--
function m.boot()
    -- make sure the plugin manager has been installed
    plugin_manager_setup()

    -- installed any required plugins by all layers
    plugin_install()

    -- set up each layer in order
    for i, lm in ipairs(layermods) do
        lm.setup()
    end
end

-- export the module
return m
