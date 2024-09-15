return {
    "github/copilot.vim",
    config = function ()
        -- as copilot is a vim plugin it doesn't have to be required...i think
        vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end
}
