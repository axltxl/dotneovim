--
-- plugin: trim.nvim
--

local core = require('core')
core.safe_require('trim', function(trim)
    trim.setup {}
end)
