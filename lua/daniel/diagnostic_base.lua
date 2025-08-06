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
vim.keymap.set('n', 'gl', vim.diagnostic.open_float,
  { noremap = true, silent = true, desc = "Open diagnostics in floating window" })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev,
  { noremap = true, silent = true, desc = "Jump to previous diagnostic item" })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next,
  { noremap = true, silent = true, desc = "Jump to next diagnostic item" })
