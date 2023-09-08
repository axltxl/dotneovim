--
-- plugin configuration
--
local core = require('core')
--
-- load all individual configurations
core.safe_require('plugins.conf.telescope')
core.safe_require('plugins.conf.lualine')
core.safe_require('plugins.conf.nvim-surround')
core.safe_require('plugins.conf.nvim-tree')
core.safe_require('plugins.conf.nvim-treesitter')
core.safe_require('plugins.conf.which-key')
core.safe_require('plugins.conf.project')
core.safe_require('plugins.conf.nvim-autopairs')
core.safe_require('plugins.conf.nvim-trim')
core.safe_require('plugins.conf.comment')
core.safe_require('plugins.conf.git')
--
---------------------------------------------
-- Individual configuration for every LSP
---------------------------------------------
core.safe_require('plugins.conf.lsp')        -- base config
core.safe_require("plugins.conf.lsp.lua")    -- lua
core.safe_require("plugins.conf.lsp.python") -- python
