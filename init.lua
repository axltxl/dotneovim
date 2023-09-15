--
-- main nvim config
-- layer-based configuration alla spacemacs
-- this will allow a configuration where pieces
-- of self-contained config are added one on top of the other,
-- each one packing everything they need in order
-- to put their food on the table.

local layers = require("core.layers")

layers.enable({
    -- Basics
    ----------------------
    "basics.foundation", -- the very basics
    "basics.window",     -- window management
    "basics.tab",        -- tab management
    "basics.telescope",  -- fuzzy finder
    "basics.file",       -- file management
    "basics.which-key",  -- spacemacs like ;)

    -- Look and feel
    ----------------------
    "theme.colorscheme", -- color scheme
    "theme.lualine",     -- powerline

    -- Basics of programming
    ----------------------
    "dev.git",        -- repositories management
    "dev.treesitter", -- syntax highlighting et al.
    "dev.surround",   -- vim-surround
    "dev.autopairs",  -- auto close pairs
    "dev.autotrim",   -- trim files upon saving
    "dev.comment",    -- toggle comment (nerdcommenter)
    "dev.project",    -- project management

    -- the good stuff
    "dev.mason",          -- package manager for LSPs, linters, etc.
    "dev.lsp",            -- lsp configuration
    "dev.dap",            -- Debug Adapter protocol configuration
    "lsp.autocompletion", -- lsp-powered autocompletion + snippet engine
    "lsp.efm",            -- efm-langserver (general purpose LSP, can be used by several languages)
    "dev.trouble",        -- diagnostics panel
    "dev.todocomments",   -- keep track of FIXMEs and TODO comments in a project, needs trouble

    -- programming languages support
    "lang.lua",    -- lua completion, lsp, etc.
    "lang.python", -- python completion, lsp, etc.
    "lang.json",   -- JSON
})

--
-- Initiate the whole thing
layers.boot()
