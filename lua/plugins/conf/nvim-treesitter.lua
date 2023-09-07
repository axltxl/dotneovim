--
-- treesitter stuff
--
-- automatically update
vim.cmd([[TSUpdate]])

-- treesitter configuration
require('nvim-treesitter.configs').setup {
  --basic settings
  ensure_installed = 'all',
  sync_installed = true,
  ignore_install = { "" },

  -- highlighting settings
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = true,
  },

  -- automatic indentation settings
  indent = { enable = true, disable = { "" } },
}
