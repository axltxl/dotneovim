--
-- layer: lsp_autocompletion
-- LSP-powered autocompletion + snippets
--

local core = require('core')

-- we need this to export the module
local m = {}

-- list of plugins required by this layer
function m.get_plugins()
    return {
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },        -- LSP source for nvim-cmp
        { 'saadparwaiz1/cmp_luasnip' },    -- Snippets source for nvim-cmp (luasnip, see below)
        { 'L3MON4D3/LuaSnip' },            -- snippets engine of choice
        { "rafamadriz/friendly-snippets" } -- an extra snippet library
    }
end

-- set up configuration for this layer
function m.setup()
    core.safe_require('luasnip', function(luasnip)
        core.safe_require('cmp', function(cmp)
            -- Configure nvim-cmp (autocompletion engine)
            -- to use luasnip as its main source
            ---------------------------------------------
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                -- Key mappings for autocompletion go in here
                ---------------------------------------------
                mapping = cmp.mapping.preset.insert({
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
                    -- C-b (back) C-f (forward) for snippet placeholder navigation.
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },

                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),

                -- set up sources used by nvim-cmp
                ---------------------------------------------
                sources = {
                    { name = 'nvim_lsp' }, -- thanks to cmp-nvim-lsp
                    { name = 'buffer' },
                    { name = 'luasnip' },
                },
            }
        end)
    end)
end

-- export the module
return m
