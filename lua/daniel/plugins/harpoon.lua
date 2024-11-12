return {
    'theprimeagen/harpoon',
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file, { noremap = true, silent = true, desc = "Harpoon add file" })
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu,
            { noremap = true, silent = true, desc = "Harpoon show tracked files" })
    end
}
