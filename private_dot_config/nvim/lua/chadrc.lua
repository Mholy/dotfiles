local highlights = require "highlights"
-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "flexoki-light",
  theme_toggle = { "doomchad", "flexoki-light" },
  changed_themes = highlights.changed_themes,
  hl_override = highlights.hl_override,
  hl_add = highlights.hl_add,
}

M.ui = {
  tabufline = {
    -- enabled = false,
    order = { "buffers", "session", "tabs" },
    modules = {
      session = function()
        local session = require "auto-session.lib"

        local success, result = pcall(function()
          return session.current_session_name(true)
        end)

        if success and result and result ~= "" then
          return "session: " .. "%#TbBufOff#" .. result .. " "
        end

        return ""
      end,
    },
  },

  statusline = {
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    order = {
      "mode",
      "file",
      "git",
      "%=",
      "lsp_msg",
      "%=",
      "diagnostics",
      "lsp",
      "cwd",
    },
  },

  cheatsheet = {
    theme = "simple", -- simple/grid
  },

  telescope = { style = "bordered" }, -- borderless / bordered

  cmp = {
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = true,
    },
  },
}

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
