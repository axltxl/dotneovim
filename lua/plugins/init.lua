--
-- plugins section ;)
--

-- install lazy.nvim (plugin manager) automatically
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


--
-- the plugins themselves
--
 require("lazy").setup({
   -- basics
   -----------
   -- https://neovimcraft.com/plugin/kyazdani42/nvim-tree.lua
   -- file tree
   {'nvim-tree/nvim-web-devicons'},-- for file icons
   {'nvim-tree/nvim-tree.lua'},

    -- fuzzy finder ;)
    { 'nvim-telescope/telescope.nvim', tag = '0.1.2', dependencies = { 'nvim-lua/plenary.nvim' }, },

   -- treesitter for syntax highlighting et al.
   { 'nvim-treesitter/nvim-treesitter'},

   -- Which-key (spacemacs-inspired)
   {'folke/which-key.nvim'},

     -- project management
    {"ahmedkhalf/project.nvim", dependencies = { 'nvim-telescope/telescope.nvim' }},

   -- editing
   -----------
   -- surrounding
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
    },

    -- auto-closing pairs
   {"windwp/nvim-autopairs"},

   -- auto trimming files upon saving them
    {"cappyzawa/trim.nvim"},

    -- auto commenting
    {'numToStr/Comment.nvim'},

   -- LSP
   -----------
   -- base lsp package manager, there's an LSP
   -- for every language, so ...
   {'williamboman/mason.nvim'},
  --
   -- this will instruct our mason what LSPs
   -- to install
   {'williamboman/mason-lspconfig.nvim'},
  --
   -- .. and this one will configure every LSP
   -- individually
   {'neovim/nvim-lspconfig'},

   -- look and feel
   -----------
  -- themes
  {'projekt0n/github-nvim-theme'},

  -- powerline
  {'nvim-lualine/lualine.nvim'},
})

-- load all plugin configurations
require('plugins.conf')
