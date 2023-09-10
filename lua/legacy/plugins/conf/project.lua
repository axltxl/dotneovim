--
-- project.nvim
--

local core = require('core')
core.safe_require('project_nvim', function(project)
    project.setup {
        -- for integration with nvim-tree
        -- source: https://neovimcraft.com/plugin/ahmedkhalf/project.nvim,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        detection_methods = { "pattern" },
        patterns = { ".git" },
        update_focused_file = {
            enable = true,
            update_root = true
        },

    }
    -- integration with telescope
    core.safe_require('telescope', function(telescope)
        telescope.load_extension('projects')
    end)
end)
