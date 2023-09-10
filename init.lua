--
-- main nvim config
--

local layers = require("core.layers")

-- FIXME: doc me
layers.enable({
    "foundation", -- the very basics
    "colorscheme", -- color scheme
    "window", -- window management
})

--
-- FIXME: doc me
layers.boot()


-- essentials is always the first
-- core.safe_require("essentials")

-- install and configure plugins
-- core.safe_require("plugins")

-- load color scheme
-- core.safe_require("colorscheme")

-- key bindings always go last
-- core.safe_require("keybindings")
