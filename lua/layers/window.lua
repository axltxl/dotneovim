--
-- layer: window
-- window management
--

local keys = require('core.keys')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        { 'sindrets/winshift.nvim' }
    }
end

-- set up configuration for this layer
function m.setup()
    -- creation and deletion
    keys.map_leader_n('wv', ':vsplit<cr>', { desc = "split vertically" })  -- split vertically
    keys.map_leader_n('ws', ':split<cr>', { desc = "split horizontally" }) -- split horizontally
    keys.map_leader_n('wd', ':q!<cr>', { desc = "close current window" })  -- remove split

    -- navigation
    keys.map_leader_n('wk', ':wincmd k<cr>') -- up
    keys.map_leader_n('wj', ':wincmd j<cr>') -- down
    keys.map_leader_n('wl', ':wincmd l<cr>') -- right
    keys.map_leader_n('wh', ':wincmd h<cr>') -- left

    -- resizing
    local window_resize_factor = 5
    keys.map_n('<C-l>', function()
        vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) + window_resize_factor)
    end)
    keys.map_n('<C-h>', function()
        vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) - window_resize_factor)
    end)
    keys.map_n('<C-k>', function()
        vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) + window_resize_factor)
    end)
    keys.map_n('<C-j>', function()
        vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) - window_resize_factor)
    end)

    -- movement (thanks to winshift)
    core.safe_require('winshift', function(_)
        keys.map_leader_n('wmk', ':WinShift up<cr>') -- up
        keys.map_leader_n('wmj', ':WinShift down<cr>') -- down
        keys.map_leader_n('wml', ':WinShift right<cr>') -- right
        keys.map_leader_n('wmh', ':WinShift left<cr>') -- left
    end)
end

-- export the module
return m
