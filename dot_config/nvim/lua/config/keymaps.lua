local desc = function(description)
  local M = { desc = description }
  return M
end

local key = vim.keymap.set
-- local silent = { silent = true }
vim.g.mapleader = "\\"

-- key("n", "<leader>r", "<cmd>source %<CR>", silent)

-- Plugins
key("n", "]b", "<cmd>BufferLineCycleNext<CR>", desc("Go to next buffer"))
key("n", "[b", "<cmd>BufferLineCyclePrev<CR>", desc("Go to previous buffer"))

key("n", "<leader>t", function()
  require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end, desc("Open Explorer (cwd)"))
