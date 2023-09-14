--
-- key bindings API
--

local DEFAULT_BINDINGOPTS = { noremap = false, remap = true }

-- we need this to export the module
local m = {}

-- a commodity function to map a key bind
function m.map(mode, keys, command, opts)
    if opts == nil then
        opts = DEFAULT_BINDINGOPTS
    else
        if opts['noremap'] == nil then
            opts['noremap'] = true
        end
        if opts['remap'] == nil then
            opts['remap'] = false
        end
    end
    vim.keymap.set(mode, keys, command, opts)
end

-- in normal mode
function m.map_n(mnemonic, command, opts)
    m.map('n', mnemonic, command, opts)
end

function m.map_leader_n(mnemonic, command, opts)
    m.map_n('<leader>' .. mnemonic, command, opts)
end

-- visual mode
function m.map_v(mnemonic, command, opts)
    m.map('v', mnemonic, command, opts)
end

function m.map_leader_v(mnemonic, command, opts)
    m.map_v('<leader>' .. mnemonic, command, opts)
end

-- insert mode
function m.map_i(mnemonic, command, opts)
    m.map('i', mnemonic, command, opts)
end

-- export the module
return m
