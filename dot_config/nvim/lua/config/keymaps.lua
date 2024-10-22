local key = vim.keymap.set
local silent = { silent = true}
vim.g.mapleader = "\\"

key("n", "<leader>r", "<cmd>source %<CR>", silent)



