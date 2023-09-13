--
-- essential stuff used all throughout
-- my config ;)

local function __FILE__() return debug.getinfo(2, 'S').source end
local function __LINE__() return debug.getinfo(2, 'l').currentline end
local function __FUNC__() return debug.getinfo(2, 'n').name end

-- we need this to export the module
local m = {}

-- log stuff
function m.log(level, msg)
    print(string.format("[%s] >> %s", level, msg))
end

function m.log_info(msg)
    m.log("INFO", msg)
end

function m.log_error(msg)
    m.log("ERROR", msg)
end

-- autocommands group used by this library
-- ----------------------------------------
-- custom autocommands are triggered by this library on the 'Core'
-- group. In order to subscribe to events on that group, you can
-- use m.create_autocmd providing a callback function
local main_autocmd_group  = vim.api.nvim_create_augroup('Core', {clear = true})

-- Easily create an User autocommand, which is kinda nightmarish
-- to understand
function m.create_autocmd(pattern_name, callback)
    vim.api.nvim_create_autocmd('User', {
        group = main_autocmd_group,
        pattern = pattern_name,
        callback = callback
    })
end

-- Execute custom autocommand
function m.exec_autocmds(pattern_name)
    vim.api.nvim_exec_autocmds('User', {group = main_autocmd_group, pattern = pattern_name})
end

-- safe require
-- its only job is to make sure that a require call
-- does not break this entire config
-- callback will be invoked if ok
function m.safe_require(mod_name, callback)
    local ok, mod = pcall(require, mod_name)
    if not ok then
        m.log_error(string.format("%s: failed to load module"))
        m.log_error(debug.traceback())
    elseif callback ~= nil then
        callback(mod)
    end
    return ok, mod
end

-- like safe_require, but silent.
-- used for when you want something to be
-- run only if a module is the import path
function m.if_mod(mod_name, callback)
    local ok, mod = pcall(require, mod_name)
    if ok then
        callback(mod)
    end
end

-- export the module
return m
