local M

M.system = function()
  local system_id = vim.loop.os_uname().sysname
  if system_id == "Linux" then
    return 0
  elseif system_id == "Windows_NT" then
    return 1
  else
    return 2
  end
end

return M
