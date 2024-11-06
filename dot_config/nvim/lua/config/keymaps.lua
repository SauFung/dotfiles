local desc = function(description)
  local M = { desc = description }
  return M
end

local config_path = vim.fn.stdpath("config")
local home_path = vim.env.HOME

local key = vim.keymap.set
-- local silent = { silent = true }
vim.g.mapleader = "\\"

-- key("n", "<leader>r", "<cmd>source %<CR>", silent)

key("n", "<A-a>", "$")
key("n", "<A-i>", "^")
key("n", "<A-c>", "0w")

key("n", "<A-h>", "<C-w>h")
key("n", "<A-j>", "<C-w>j")
key("n", "<A-k>", "<C-w>k")
key("n", "<A-l>", "<C-w>l")
key("n", "<A-=>", "<C-w>=")
key("n", "<A-H>", "<C-w><")
key("n", "<A-J>", "<C-w>+")
key("n", "<A-K>", "<C-w>-")
key("n", "<A-L>", "<C-w>>")

key("n", "<A-q>", "<cmd>bd<CR>")
key("n", "<leader>q", "<cmd>q<CR>")

----- Plugins -----

-- Bufferline
key("n", "]b", "<cmd>BufferLineCycleNext<CR>", desc("Go to next buffer"))
key("n", "[b", "<cmd>BufferLineCyclePrev<CR>", desc("Go to previous buffer"))

-- Neotree
key("n", "<leader>cd", "<cmd>Neotree<CR>", desc("Open current directory"))
key("n", "<leader>ch", "<cmd>Neotree " .. home_path .. "<CR>", desc("Open home directory"))
key("n", "<leader>cc", "<cmd>Neotree " .. config_path .. "<CR>", desc("Open config directory"))

-- Telescope
key("n", "<leader>ff", "<cmd>Telescope find_files<CR>", desc("Telescope find files"))
key("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", desc("Telescope live grep"))
key("n", "<leader>fb", "<cmd>Telescope buffers<CR>", desc("Telescope buffers"))
key("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", desc("Telescope help tags"))
