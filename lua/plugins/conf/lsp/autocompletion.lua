--
-- autocompletion with nvim-cmp with lsp integration
-- based on: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
--

local core = require("core")
local mod = {}

-- nvim-cmp setup
function mod.setup()
    core.safe_require('luasnip', function(luasnip)
        core.safe_require('cmp', function(cmp)
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
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
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
            }
        end)
    end)
end

-- Add additional capabilities supported by nvim-cmp
function mod.get_nvim_cmp_capabilities()
    local capabilities = nil
    core.safe_require('cmp_nvim_lsp', function(cmp_nvim_lsp)
        capabilities = cmp_nvim_lsp.default_capabilities()
    end)
    return capabilities
end

return mod
