--
-- plugin: nvim-tree
--

require('nvim-tree').setup({
  filters = {
    git_ignored = false -- do not ignore .gitignore listed files
  }
})

