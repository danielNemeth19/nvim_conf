return {
  'olimorris/codecompanion.nvim',
  opts = {},
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = true,
  lazy = true,
  cmd = {
    'CodeCompanion',
    'CodeCompanionChat',
    'CodeCompanionCmd',
    'CodeCompanionActions',
  },
  keys = {
    { '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle Chat', mode = { 'n', 'v' } },
    { '<leader>ca', '<cmd>CodeCompanionActions<cr>', desc = 'Prompt Actions', mode = { 'n', 'v' } },
  },
}
