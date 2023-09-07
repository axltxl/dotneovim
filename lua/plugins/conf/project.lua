--
-- project.nvim
--

require("project_nvim").setup {
  -- for integration with nvim-tree
  -- source: https://neovimcraft.com/plugin/ahmedkhalf/project.nvim,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  detection_methods = {"pattern"},
  patterns = {".git"},
  update_focused_file = {
    enable = true,
    update_root = true
  },
}

-- integration with telescope ;)
require('telescope').load_extension('projects')
