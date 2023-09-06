--
-- basic editor settings
--

-- disable netrw at the very start of your init.lua
-- (this is required by nvim-tree, see: plugins.lua)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.showcmd       = true
vim.opt.autoindent    = true -- automatic indentation
vim.opt.expandtab     = true -- spaces for indentation
vim.opt.tabstop       = 2    -- how many spaces?
vim.opt.list          = true
vim.opt.listchars     = { lead = '.', eol   = '↵', space = '.', trail = '.', extends = '<', precedes = '>', }
vim.opt.shiftwidth    = 2    --  << >>
vim.opt.swapfile      = false -- disable swap files and swap files by default
vim.opt.number        = true -- display line numbers
vim.opt.wrap          = false -- disable wordwrap
vim.opt.mouse         = ""    -- disable mouse
vim.opt.termguicolors = true  -- enable terminal colors

-- automatically remove trailing
-- whitespace upon saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})





