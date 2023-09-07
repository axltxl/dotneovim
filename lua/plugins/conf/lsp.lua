--
-- LSP configuration goes in here


function on_attach(_, _)
end

-- base lsp package manager
local ok, mason = pcall(require, 'mason')

if ok then
  -- mason configuration
  mason.setup()

  -- this is where we tell mason what LSPs
  -- do we want to be installed
  local ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
  if ok then
    mason_lspconfig.setup({
      -- lua
      ensure_installed = { "lua_ls" }
    })
  end
  --
  -- .. and this one will configure every LSP
  -- ***********************************************
  local ok, lspconfig = pcall(require, 'lspconfig')
  if ok then
    -- lua
    lspconfig.lua_ls.setup {}
  end
end

--
-- automatically format file upon saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})
