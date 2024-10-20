return {
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    return "make install_jsregexp"
                end)
            },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
        },
        config = function()
            vim.api.nvim_set_hl(0, "CmpCursor", { fg = "black", bg = "#9ccfd8", bold = true })
            vim.api.nvim_set_hl(0, "CmpFloatBorder", { fg = "white", bg = "#1f1f28" })
            local cmp = require('cmp')
            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                mapping = cmp.mapping.preset.insert({
                    -- Ctrl-y key confirms completion item
                    ['<C-y>'] = cmp.mapping.confirm({ select = false }),

                    -- Ctrl + space triggers completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        border = "rounded",
                        winhighlight = "CursorLine:CmpCursor,FloatBorder:CmpFloatBorder"
                    },
                    documentation = {
                        border = "rounded",
                        winhighlight = "CursorLine:CmpCursor,FloatBorder:CmpFloatBorder"
                    }
                }
            })
        end
    }
}
