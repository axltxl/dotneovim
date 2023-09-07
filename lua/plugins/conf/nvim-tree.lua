--
-- plugin: nvim-tree
--

local core = require('core')
core.safe_require('nvim-tree', function(tree)
    tree.setup {
        -- sync root with current cwd (this is important for when switching between projects)
        sync_root_with_cwd = true,
        filters = {
            git_ignored = false, -- do not ignore .gitignore listed files
        }
    }
end)
