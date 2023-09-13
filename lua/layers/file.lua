--
-- layer: file management
--

local core = require('core')
local keys = require('core.keys')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    -- https://neovimcraft.com/plugin/kyazdani42/nvim-tree.lua
    -- file tree
    return {
        { 'nvim-tree/nvim-web-devicons' }, -- for file icons
        { 'nvim-tree/nvim-tree.lua' }
    }
end

-- set up configuration for this layer
function m.setup()
    -- set up plugins (nvim-tree)
    core.safe_require('nvim-tree', function(tree)
        -- disable netrw at the very start of your init.lua
        -- (this is required by nvim-tree, see: plugins.lua)
        vim.g.loaded_netrw       = 1
        vim.g.loaded_netrwPlugin = 1

        -- set up nvim-tree
        tree.setup {
            -- sync root with current cwd (this is important for when switching between projects)
            sync_root_with_cwd = true,
            filters = {
                git_ignored = false, -- do not ignore .gitignore listed files
            }
        }
    end)

    -- keys section --
    -- creation and deletion
    keys.map_leader_n('fn', ':new<cr>') -- new buffer on window
    keys.map_leader_n('fs', ':w<cr>')   -- save current buffer

    -- nvim-tree
    core.safe_require('nvim-tree', function(_)
        keys.map_leader_n('ft', ':NvimTreeToggle<cr>')   -- toggle nvim-tree
        keys.map_leader_n('<tab>', ':NvimTreeFocus<cr>') -- toggle nvim-tree
        keys.map_n('<C-b>', ':NvimTreeToggle<cr>')       -- toggle nvim-tree
    end)

    -- ***********************
    -- telescope integration
    -- ***********************
    core.if_mod('telescope.builtin', function(builtin)
        keys.map_leader_n('ff',
            function()
                builtin.find_files({
                    hidden = true,
                    no_ignore = true
                })
            end)
        keys.map_leader_n('fg', builtin.live_grep)
        keys.map_leader_n('fb', builtin.buffers)
        keys.map_leader_n('fh', builtin.help_tags)
    end)
end

-- export the module
return m
