--
-- essential stuff used all throughout
-- my config ;)

function __FILE__() return debug.getinfo(2, 'S').source end

function __LINE__() return debug.getinfo(2, 'l').currentline end

function __FUNC__() return debug.getinfo(2, 'n').name end

-- we need this to export the module
local m = {}

-- log stuff
function m.log(level, msg)
    local ctx = __FUNC__() .. ':' .. __FILE__()
    print(">> [" .. level .. "] [" .. ctx .. "] " .. msg)
end

function m.log_info(msg)
    m.log("INFO", msg)
end

function m.log_error(msg)
    m.log("ERROR", msg)
end

-- safe require
-- its only job is to make sure that a require call
-- does not break this entire config
-- callback will be invoked if ok
function m.safe_require(mod_name, callback)
    local ok, mod = pcall(require, mod_name)
    if not ok then
        m.log_error(mod_name .. ": failed to load module")
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
