require "nvchad.options"

local o = vim.o
local g = vim.g
o.cursorlineopt = "both" -- to enable cursorline!
o.relativenumber = true
o.scrolloff = 5
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

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

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank {
      higroup = "Visual",
      timeout = 300,
      on_visual = false,
    }
  end,
})

-- Restore cursor position when opening a file
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
local usercmd = vim.api.nvim_create_user_command

usercmd("Termh", function()
  require("nvchad.term").new { pos = "sp" }
end, {
  desc = "Open a new horizontal terminal",
})

usercmd("Termv", function()
  require("nvchad.term").new { pos = "vsp" }
end, {
  desc = "Open a new vertical terminal",
})

usercmd("Themes", function()
  require("nvchad.themes").open { style = "bordered" }
end, {
  desc = "Open the theme selector",
})

usercmd("Jless", function()
  require("nvchad.term").toggle {
    id = "jless",
    pos = "bo vsp",
    size = 1,
    cmd = function()
      local file = vim.fn.expand "%"

      -- If no file, save it to /tmp
      if file == "" then
        file = "/tmp/tmp.json"
        vim.cmd("w! " .. file)
      end

      return "jless " .. file
    end,
  }
end, {
  desc = "Open a new terminal with jless",
})
