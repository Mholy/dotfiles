require "nvchad.autocmds"

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

usercmd("TermH", function()
  require("nvchad.term").new { pos = "sp" }
end, {
  desc = "Open a new horizontal terminal",
})

usercmd("TermV", function()
  require("nvchad.term").new { pos = "vsp" }
end, {
  desc = "Open a new vertical terminal",
})

usercmd("Themes", function()
  require("nvchad.themes").open { style = "bordered" }
end, {
  desc = "Open the theme selector",
})

usercmd("LgLog", function()
  local current_file = vim.fn.expand "%:p"

  require("nvchad.term").new {
    pos = "bo vsp",
    size = 1,
    cmd = "lazygit -f " .. current_file,
  }
end, { desc = "Open Lazygit file log" })
