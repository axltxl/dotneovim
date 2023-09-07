--
-- main nvim config
--

local core = require("core")

-- essentials is always the first
core.safe_require("essentials")

-- install and configure plugins
core.safe_require("plugins")

-- load color scheme
core.safe_require("colorscheme")

-- key bindings always go last
core.safe_require("keybindings")
