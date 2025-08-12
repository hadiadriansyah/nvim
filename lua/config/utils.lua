local M = {}
function M.exists(exe)
  return vim.fn.executable(exe) == 1
end
return M
