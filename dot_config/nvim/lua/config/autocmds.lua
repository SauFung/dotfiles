-- 设置不同文件缩进
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lua",
  },
  callback = function()
    vim.o.tabstop = 2
    vim.o.softtabstop = 2
    vim.o.shiftwidth = 2
    vim.o.expandtab = true
  end,
})

-- 按 q 退出
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "help",
    "checkhealth",
    "netrw",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- 复制时高亮
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- 去除自动注释
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  command = "set formatoptions-=cro",
})

-- 自动切换输入法
local linux_status, win_status
local system = vim.loop.os_uname().sysname
local is_wsl = vim.fn.has("wsl")
local get_status
-- 获取切换前输入法状态，并切换到英文输入法
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    if is_wsl == 0 and system == "Linux" then
      -- linux_status = 1 ==> English IM
      -- linux_status = 2 ==> Chinese IM
      linux_status = tonumber(vim.fn.system("fcitx5-remote"))
      if linux_status == 2 then
        -- fcitx5-remote -c ==> English IM
        vim.api.nvim_command(":silent :!fcitx5-remote -c")
      end
    end

    if is_wsl == 1 or system == "Window_NT" then
      -- win_status = 1033 ==> English IM
      -- win_status = 2052 ==> Chinese IM
      get_status, _ = vim.fn.system(IM_SELECT)
      win_status = tonumber(get_status)
      if win_status == 2052 then
        local im_1033 = ":!" .. IM_SELECT .. " 1033"
        vim.api.nvim_command(im_1033)
      end
    end
  end,
})

-- 根据状态自动切换输入法
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    if is_wsl == 0 and system == "Linux" then
      if linux_status == 2 then
        -- fcitx5-remote -t ==> Chinese IM
        vim.api.nvim_command(":!fcitx5-remote -t")
      end
    end

    if is_wsl == 1 or system == "Window_NT" then
      if win_status == 2052 then
        local im_2052 = ":!" .. IM_SELECT .. " 2052"
        vim.api.nvim_command(im_2052)
        -- print(win_status)
        -- print("hello")
      end
    end
  end,
})

----- plugins -----

-- nvim-linter
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    require("lint").try_lint()
  end,
})

-- conform
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
