--
-- main nvim config
--

local layers = require("core.layers")

-- FIXME: doc me
layers.enable({
    -- Basics
    ----------------------
    "foundation", -- the very basics
    "window", -- window management
    "tab", -- tab management
    "telescope", -- fuzzy finder
    "file", -- file management

    -- Look and feel
    ----------------------
    "colorscheme", -- color scheme
    "lualine", -- powerline
    "which-key", -- spacemacs like ;)

    -- Basics of programming
    ----------------------
    "git", -- repositories management
    "treesitter", -- syntax highlighting et al.
    "surround", -- vim-surround
    "autopairs", -- auto close pairs
    "autotrim", -- trim files upon saving
    "comment", -- toggle comment (nerdcommenter)
    "project", -- project management
    -- "todos",

    -- the good stuff
    "mason", -- package manager for LSPs, linters, etc.
    "lsp",
    -- "lsp_autocompletion"
    -- "lsp_snippets",
    "lang_lua",
    -- "lsp_python",
    -- "lsp_diagnostics",
})

--
-- FIXME: doc me
layers.boot()
