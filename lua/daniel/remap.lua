vim.keymap.set("n", "<leader>í", vim.cmd.Ex, {desc = "Navigate back to file explorer"})

-- Allows to move highlighted row(s) up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "Move highlighted row down"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "Move highlighted row up"})

-- Makes sure cursor stays in position when "J" is pressed
--vim.keymap.set("n", "J", "mzJ`z")

-- Enables copying yanked content over and over 
vim.keymap.set("x", "<leader>p", [["_dP]], {desc = "Enables copying yanked content over and over"})

-- Runs all tests of the current lua file
vim.keymap.set("n", "<leader>t",'<cmd>PlenaryBustedFile %<CR>', { desc = "Runs all tests of the current lua file"})
