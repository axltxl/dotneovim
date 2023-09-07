--
-- which-key conf
--


local core = require('core')
core.safe_require('which-key', function(which_key)
    which_key.setup {}
end)
