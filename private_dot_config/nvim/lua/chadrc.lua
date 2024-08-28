local highlights = require "highlights"

---@type ChadrcConfig
local M = {}

local stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.base46 = {
  theme = "nano-light",
  theme_toggle = { "penumbra_dark", "nano-light" },
  changed_themes = highlights.changed_themes,
  hl_override = highlights.hl_override,
  hl_add = highlights.hl_add,
}

M.ui = {
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
