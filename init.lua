--
-- main nvim config
--

local layers = require("core.layers")

-- FIXME: doc me
layers.enable({
    -- Basics
    ----------------------
    "foundation", -- the very basics

    "window", -- window management
    "tab", -- tab management

    "telescope", -- fuzzy finder
    "file", -- file management

    -- Look and feel
    ----------------------
    "colorscheme", -- color scheme
    "lualine",
    "which-key", -- spacemacs like ;)

    -- Basics of programming
    ----------------------
    "git", -- repositories management
    "surround",
    "autopairs",
    "autotrim",
    "comment",
})

--
-- FIXME: doc me
layers.boot()
