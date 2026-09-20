vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end
})

-- Enable Treesitter highlighting for all filetypes with a parser
vim.api.nvim_create_autocmd("FileType", {
  callback = function ()
    pcall(vim.treesitter.start)
  end,
})
