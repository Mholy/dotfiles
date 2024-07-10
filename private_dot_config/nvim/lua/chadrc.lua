local highlights = require "highlights"

---@type ChadrcConfig
local M = {}

local stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.ui = {
  theme = "nano-light",
  theme_toggle = { "everforest", "nano-light" },
  hl_override = highlights.hl_override,
  hl_add = highlights.hl_add,
  changed_themes = highlights.changed_themes,

  tabufline = {
    -- enabled = false,
    order = { "buffers", "tabs" },
    modules = {
      -- You can add your custom component
      abc = function()
        return "hi"
      end,
    },
  },

  statusline = {
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal

    order = { "mode", "file", "session", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd" },
    modules = {
      git = function()
        if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status then
          return ""
        end

        local git_status = vim.b[stbufnr()].gitsigns_status_dict

        local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
        local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
        local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
        -- branch_name will be displayed as session name
        -- local branch_name = " " .. git_status.head

        return " " .. added .. changed .. removed
      end,
      session = function()
        local session = require "auto-session.lib"

        local success, result = pcall(function()
          return session.current_session_name()
        end)

        if success then
          return result
        end

        return ""
      end,
    },
  },
}

---@diagnostic disable-next-line: missing-fields
M.term = {
  -- this will highlight the term window differently
  hl = "Normal:term,WinSeparator:WinSeparator",

  sizes = { sp = 0.3, vsp = 0.3 },
  float = {
    relative = "editor",
    width = 0.9,
    height = 0.9,
    row = 0.05,
    col = 0.05,
    border = "single",
  },
  -- horizontal = { location = "rightbelow", size = 0.3 },
  -- vertical = { location = "rightbelow", size = 0.3 },
  shell = vim.o.shell,
}

return M
