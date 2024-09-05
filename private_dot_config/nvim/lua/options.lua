require "nvchad.options"

local o = vim.o
local g = vim.g
o.cursorlineopt = "both" -- to enable cursorline!
o.relativenumber = true
o.scrolloff = 5
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
g.mapleader = " "

local g = vim.g
-- Hello, is this Neovide?
if g.neovide then
  -- Display
  o.guifont = "Iosevka_SS05,Iosevka_Nerd_Font:h15:#h-none"
  g.neovide_text_gamma = 0.8
  g.neovide_text_contrast = 0.1
  g.neovide_fullscreen = true
  g.neovide_padding_top = 0
  g.neovide_padding_bottom = 0
  g.neovide_padding_right = 0
  g.neovide_padding_left = 0
  g.neovide_floating_blur_amount_x = 0
  g.neovide_floating_blur_amount_y = 0
  g.neovide_floating_shadow = false

  -- Functionality
  g.neovide_refresh_rate = 120
  g.neovide_refresh_rate_idle = 5
  g.neovide_hide_mouse_when_typing = true
  g.neovide_input_macos_option_key_is_meta = "both"
  g.neovide_input_use_logo = 1

  -- Cursor settings
  -- g.neovide_cursor_animate_command_line = false
  g.neovide_cursor_vfx_mode = "pixiedust"
end

-- Auto commands
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank {
      higroup = "Visual",
      timeout = 300,
      on_visual = false,
    }
  end,
})

local wezterm_toggle_padding = function(enable)
  local config_path = os.getenv "WEZTERM_CONFIG_FILE"
  local padding = '{ left = "1cell", right = "1cell", top = "0.5cell", bottom = "0.5cell" }'
  local padding_removed = "{ left = 0, right = 0, top = 0, bottom = 0 }"
  local command = "silen !sed -i -e"

  if not config_path then
    return
  end

  if enable then
    command = command .. " 's/" .. padding .. "/" .. padding_removed .. "/g' " .. config_path
  else
    command = command .. " 's/" .. padding_removed .. "/" .. padding .. "/g' " .. config_path
  end

  vim.cmd(command)
end

-- autocmd("VimEnter", {
--   callback = function()
--     wezterm_toggle_padding(true)
--   end,
--   desc = "Add WezTerm padding when entering Neovim",
-- })

-- autocmd("VimLeavePre", {
--   callback = function()
--     wezterm_toggle_padding(false)
--   end,
--   desc = "Restore WezTerm padding when leaving Neovim",
-- })

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- User commands
-- local usercmd = vim.api.nvim_create_user_command
