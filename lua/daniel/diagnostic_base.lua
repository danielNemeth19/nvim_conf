vim.diagnostic.config({
    float = {
        border = 'rounded'
    },
    underline = false,
    virtual_text = {
        source = "if_many",
        spacing = 2,
        prefix = "●"
    }
})
vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)
