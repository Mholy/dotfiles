require "nvchad.options"

local o = vim.o

o.cursorlineopt = "both" -- to enable cursorline!
o.relativenumber = true
o.scrolloff = 3
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
o.title = true
o.titlestring = "%t (%{fnamemodify(getcwd(),':~')})"

local opt = vim.opt

local function escape(str)
  -- You need to escape these characters to work correctly
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru_shift = [[ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮË]]
local en_shift = [[QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>~]]

opt.langmap = vim.fn.join({
  escape(ru_shift) .. ";" .. escape(en_shift),
  escape(ru) .. ";" .. escape(en),
}, ",")

local g = vim.g

g.codeium_disable_bindings = 1

-- Hello, is this Neovide?
if g.neovide then
  -- Display
  o.guifont = "Codelia_Ligatures:h14"
  g.neovide_text_gamma = 0.8
  g.neovide_text_contrast = 0.1
  -- g.neovide_fullscreen = true

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
