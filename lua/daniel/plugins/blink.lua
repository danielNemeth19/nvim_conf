return {
    -- config documentation: https://cmp.saghen.dev/configuration/reference.html
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
    },
    version = 'v0.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        completion = {
            accept = {
                auto_brackets = {
                    enabled = false
                }
            },
            list = {
                selection = { preselect = true, auto_insert = true }
            },
            ghost_text = { enabled = true },
            menu = {
                max_height = 20,
                border = "rounded",
            },
            documentation = {
                auto_show = true,
                treesitter_highlighting = true,
                window = {
                    border = "rounded"
                }
            }
        },
        keymap = { preset = 'default' },
        appearance = {
            nerd_font_variant = 'mono'
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            -- optionally disable cmdline completions
            -- cmdline = {},
        },
        signature = { enabled = true }
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" }
}
