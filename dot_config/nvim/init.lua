-- 全局变量配置软件路径
WIN32YANK = "/mnt/c/Env/win32yank/win32yank.exe"
GH_MIRROR = "https://ghp.ci/https://github.com/"

local system = vim.loop.os_uname().sysname
local is_wsl = vim.fn.has("wsl")
local win_prefix = "C:"
local linux_prefix = "/mnt/c"
local im_select_path = "/Env/im-select/im-select.exe"

if is_wsl == 0 then
  if system == "Linux" then
    IM_SELECT = nil
  end
  if system == "Windows_NT" then
    IM_SELECT = win_prefix .. im_select_path
  end
end

if is_wsl == 1 then
  IM_SELECT = linux_prefix .. im_select_path
end

-- GH_MIRROR = "https://kkgithub.com/"

require("config")
