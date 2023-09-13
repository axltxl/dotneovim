--
-- layer: color scheme
--

local core              = require('core')
local keys              = require('core.keys')
local utils             = require('core.utils')

-- my color themes of choice
local colorscheme_light = 'rose-pine-dawn'
local colorscheme_dark  = 'rose-pine-moon'

local function desc(msg)
    return utils.desc('colorscheme', msg)
end

-- toggle between light and dark color themes
local function toggle()
    if vim.g.colors_name == colorscheme_dark then
        vim.cmd.colorscheme(colorscheme_light)
    else
        vim.cmd.colorscheme(colorscheme_dark)
    end
end

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        -- all my color themes go in here ;)
        { 'projekt0n/github-nvim-theme' },
        { 'morhetz/gruvbox' },
        { 'catppuccin/vim' },
        { 'rose-pine/neovim' },
    }
end

-- set up configuration for this layer
function m.setup()
    -- dark by default
    vim.cmd.colorscheme(colorscheme_dark)

    -- key bindings
    -- -------------
    -- toggle between light and dark color themes
    keys.map_leader_n(';c<space>', function() toggle() end, { desc = desc("toggle light/dark") })

    -- list color themes on Telescope
    core.if_mod('telescope', function(_)
        keys.map_leader_n(';cc', function() vim.cmd([[Telescope colorscheme]]) end)
    end, { desc = desc("set color scheme") })
end

-- export the module
return m
