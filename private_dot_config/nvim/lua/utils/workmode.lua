-- ~/.config/nvim/lua/utils/workmode.lua
local M = {}

local work_paths = {
  vim.fn.expand "~/code/work",
}

function M.is_work_project()
  local cwd = vim.fn.getcwd()
  for _, path in ipairs(work_paths) do
    if cwd:find(path, 1, true) == 1 then
      return true
    end
  end
  return false
end

return M
