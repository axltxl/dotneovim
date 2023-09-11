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
    "foundation", -- the very basics
    "window",     -- window management
    "tab",        -- tab management
    "telescope",  -- fuzzy finder
    "file",       -- file management

    -- Look and feel
    ----------------------
    "colorscheme", -- color scheme
    "lualine",     -- powerline
    "which-key",   -- spacemacs like ;)

    -- Basics of programming
    ----------------------
    "git",        -- repositories management
    "treesitter", -- syntax highlighting et al.
    "surround",   -- vim-surround
    "autopairs",  -- auto close pairs
    "autotrim",   -- trim files upon saving
    "comment",    -- toggle comment (nerdcommenter)
    "project",    -- project management

    -- the good stuff
    "mason",              -- package manager for LSPs, linters, etc.
    "lsp",                -- lsp configuration
    "lsp_autocompletion", -- lsp-powered autocompletion + snippet engine
    "trouble",            --diagnostics panel
    "todocomments",       -- keep track of FIXMEs and TODO comments in a project, needs trouble

    -- programming languages support
    "lang_lua",    -- lua completion, lsp, etc.
    "lang_python", -- lua completion, lsp, etc.
})

--
-- Initiate the whole thing
layers.boot()
