return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" },
        },
        opts = {
            debug = true,
        },
        config = function()
            require("CopilotChat").setup()
            vim.keymap.set("n", "<leader>cc", function()
                vim.cmd("CopilotChatToggle")
            end, { noremap = true, silent = true, desc = "Toggles copilot chat" })
        end,
    }
}
