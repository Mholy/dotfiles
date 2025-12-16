local highlights = require "highlights"
-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "gruvchad",
  changed_themes = highlights.changed_themes,
  integrations = {},
  transparency = false,
  hl_add = highlights.hl_add,
  hl_override = highlights.hl_override,
  theme_toggle = { "gruvchad", "gruvbox_light" },
}

M.ui = {
  tabufline = {
    enabled = true,
    lazyload = true,
    bufwidth = 21,
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
    enabled = true,
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
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
    icons_left = false, -- only for non-atom styles!
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    abbr_maxwidth = 60,
    format_colors = {
      tailwind = true,
      lsp = true,
      icon = "󱓻",
    },
  },
}

M.term = {
  startinsert = true,
  base46_colors = true,
  winopts = { number = false, relativenumber = false },
  sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
  float = {
    relative = "editor",
    row = 0.3,
    col = 0.25,
    width = 0.5,
    height = 0.4,
    border = "single",
  },
  -- horizontal = { location = "rightbelow", size = 0.3 },
  -- vertical = { location = "rightbelow", size = 0.3 },
  shell = vim.o.shell,
}

M.lsp = {
  signature = true,
}

M.cheatsheet = {
  theme = "grid", -- simple/grid
  excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
}

M.mason = { pkgs = {}, skip = {} }

M.colorify = {
  enabled = true,
  mode = "virtual", -- fg, bg, virtual
  virt_text = "󱓻 ",
  highlight = { hex = true, lspvars = true },
}

return M
