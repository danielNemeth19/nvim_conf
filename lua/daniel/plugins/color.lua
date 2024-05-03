return {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    opts = {
        styles = {
            transparency = true,
            bold = false,
            italic = false,
        },
        highlight_groups = {
            Keyword = {
                italic = true,
                bold = true
            },
            ['@variable.builtin'] = {
                italic = true
            },
            ['@keyword.conditional'] = {
                italic = true
            },
            ['@keyword.repeat'] = {
                italic = true
            }
        }
    },
    config = function(_, opts)
        require('rose-pine').setup(opts)
        vim.cmd('colorscheme rose-pine')
    end
}
