return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = true,
      window = {
        layout = "vertical",
        border = "rounded",
        width = 100
      }
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)
      vim.keymap.set("n", "<leader>cc", function()
        vim.cmd("CopilotChatToggle")
      end, { noremap = true, silent = true, desc = "Toggles copilot chat" })
    end,
  }
}
