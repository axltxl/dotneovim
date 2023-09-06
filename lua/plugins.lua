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
   {'nvim-tree/nvim-tree.lua', config = function() require('nvim-tree').setup() end},
    -- fuzzy finder ;)
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.2',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
   -- treesitter for syntax highlighting et al.
   {
     'nvim-treesitter/nvim-treesitter',
     config = function()
       -- automatically update
       vim.cmd([[TSUpdate]])

       -- treesitter configuration
       require('nvim-treesitter.configs').setup {
         --basic settings
         ensure_installed = 'all',
         sync_installed = true,
         ignore_install = {""},

         -- highlighting settings
         highlight = {
           enable = true,
           disable = {""},
           additional_vim_regex_highlighting = true,
         },

         -- automatic indentation settings
         indent = { enable = true, disable = {""}},
       }
     end
   },
   -- Which-key (spacemacs-inspired)
   {'folke/which-key.nvim',
     config = function()
        vim.o.timeout    = true
        vim.o.timeoutlen = 300
        require("which-key").setup {}
      end
    },

   -- editing
   -----------
   -- surrounding
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
    },

   -- LSP
   -----------
   -- base lsp package manager, there's an LSP
   -- for every language, so ...
   {'williamboman/mason.nvim',
      config = function()
        require('mason').setup()
      end
   },
   -- this will instruct our mason what LSPs
   -- to install
   {'williamboman/mason-lspconfig.nvim',
     config = function()
        require('mason-lspconfig').setup({
          ensure_installed = { "lua_ls" }
        })
     end
   },
   -- .. and this one will configure every LSP
   -- individually
   {'neovim/nvim-lspconfig',
      config = function()
        -- lua
        require('lspconfig').lua_ls.setup{}
      end
   },

   -- look and feel
   -----------
  {'projekt0n/github-nvim-theme', config = function() vim.cmd([[colorscheme github_dark]]) end},
  {'nvim-lualine/lualine.nvim', config = function() require('lualine').setup() end},
})
