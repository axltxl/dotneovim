--
-- plugin configuration
--
-- load all individual configurations
require('plugins.conf.telescope')
require('plugins.conf.lualine')
require('plugins.conf.nvim-surround')
require('plugins.conf.nvim-tree')
require('plugins.conf.nvim-treesitter')
require('plugins.conf.which-key')
require('plugins.conf.project')
require('plugins.conf.nvim-autopairs')
require('plugins.conf.nvim-trim')
require('plugins.conf.comment')
--
---------------------------------------------
-- Individual configuration for every LSP
---------------------------------------------
require('plugins.conf.lsp')        -- base config
require("plugins.conf.lsp.lua")    -- lua
require("plugins.conf.lsp.python") -- python
