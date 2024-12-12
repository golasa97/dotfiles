
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>,", vim.cmd.tabp)
vim.keymap.set("n", "<leader>.", vim.cmd.tabnext)
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")


vim.keymap.set("n", "<leader>ss", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>sv", vim.cmd.split)
vim.keymap.set("n", "<leader>cd", vim.cmd.tcd)
vim.keymap.set("n", "<leader>tt", vim.cmd.tabnew)



vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
