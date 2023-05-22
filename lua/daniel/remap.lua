vim.keymap.set("n", "<leader>í", vim.cmd.Ex)

-- Allows to move highlighted row(s) up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Makes sure cursor stays in position when "J" is pressed
--vim.keymap.set("n", "J", "mzJ`z")

-- Enables copying yanked content over and over 
vim.keymap.set("x", "<leader>p", [["_dP]])

