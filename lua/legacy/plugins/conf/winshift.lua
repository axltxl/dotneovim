--
-- winshift configuration
--

local core = require('core')

core.safe_require('winshift', function(winshift)
    winshift.setup({
        highlight_moving_win = true, -- Highlight the window being moved
        focused_hl_group = "Visual", -- The highlight group used for the moving window
        moving_win_options = {
            -- These are local options applied to the moving window while it's
            -- being moved. They are unset when you leave Win-Move mode.
            wrap = false,
            cursorline = false,
            cursorcolumn = false,
            colorcolumn = "",
        },
        keymaps = {
            disable_defaults = false, -- Disable the default keymaps
            win_move_mode = {
                ["h"] = "left",
                ["j"] = "down",
                ["k"] = "up",
                ["l"] = "right",
            }
        }
    })
end)
