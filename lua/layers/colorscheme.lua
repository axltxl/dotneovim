--
-- layer: color scheme
--


-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        { 'projekt0n/github-nvim-theme' }
    }
end

-- set up configuration for this layer
function m.setup()
    -- Set colorscheme
    local ok, _ = pcall(vim.cmd, 'colorscheme github_dark')
    if not ok then
        vim.cmd 'colorscheme default' -- if the above fails, then use default
    end
end

-- export the module
return m
