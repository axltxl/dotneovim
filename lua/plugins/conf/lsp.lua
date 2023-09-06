--
-- LSP configuration goes in here
--

-- base lsp package manager
require('mason').setup()

-- mason configuration
require('mason-lspconfig').setup({

  -- lua
  ensure_installed = { "lua_ls" }

})

-- .. and this one will configure every LSP
-- ***********************************************

-- lua
require('lspconfig').lua_ls.setup{}
