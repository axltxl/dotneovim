--
-- main nvim config
--

local layers = require("core.layers")

-- FIXME: doc me
layers.enable({
    "foundation", -- the very basics
    "colorscheme", -- color scheme
    "which-key", -- spacemacs like ;)

    "window", -- window management
    "tab", -- tab management

    "telescope", -- fuzzy finder
    "file", -- file management

})

--
-- FIXME: doc me
layers.boot()


-- FIXME: remove me
-- essentials is always the first
-- core.safe_require("essentials")

-- install and configure plugins
-- core.safe_require("plugins")

-- load color scheme
-- core.safe_require("colorscheme")

-- key bindings always go last
-- core.safe_require("keybindings")
