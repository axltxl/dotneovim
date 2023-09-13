--
-- Layers engine
-- Configuration is added as a series
-- of "layers", one of top of the other
-- so that they are self contained and coupling
-- is avoided
--

local core = require('core')
local config = require('core.config')

-- we need this to export the module
local m = {}

-- internal list of layer modules go in here
-- see lua/layers directory
local layermods = {}

-- Bootstrap plugin manager (lazy)
local function plugin_manager_setup()
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
local function plugin_install()
    local plugins = {}
    for _, lm in ipairs(layermods) do
        local lplugins = lm.get_plugins()
        if lplugins ~= nil then
            for _, lplug in ipairs(lplugins) do
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
    for _, layer in ipairs(layers) do
        if config.get('core.layer.unsafe_load') == false then
            core.safe_require('layers.' .. layer, function(l)
                table.insert(layermods, l)
            end)
        else
            table.insert(layermods, require('layers.' .. layer))
        end
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
    for _, lm in ipairs(layermods) do
        lm.setup()
    end

    -- Trigger 'CoreLayerDone' event (pattern)
    core.exec_autocmds('CoreLayersDone')
end

-- export the module
return m
