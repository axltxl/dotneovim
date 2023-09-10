--
-- auto-comment
-- 'numToStr/Comment.nvim',
--
local core = require("core")

core.safe_require('Comment', function(comment)
    comment.setup({
        mappings = {
            basic = false,
            extra = false,
        },
    })
end)
