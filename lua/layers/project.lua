----
-- layer: project
-- project management
--

local core = require('core')
local keys = require('core.keys')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        { "ahmedkhalf/project.nvim" },
    }
end

-- set up configuration for this layer
function m.setup()
    -- set up plugin
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

        core.if_mod('telescope', function(telescope)
            -- integrate with telescope
            telescope.load_extension('projects')

            -- key bindings (open projects in telescope)
            keys.map_leader_n('pp', telescope.extensions.projects.projects)
        end)
    end)
end

-- export the module
return m
