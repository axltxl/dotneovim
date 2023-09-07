--
-- colorscheme settings
--

-- Set colorscheme (see plugins)
local ok, _ = pcall(vim.cmd, 'colorscheme github_dark')
if not ok then
    vim.cmd 'colorscheme default' -- if the above fails, then use default
end
