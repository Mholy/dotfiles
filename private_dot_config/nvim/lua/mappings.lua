require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

-- LSP diagnostic location list
-- nomap("n", "<leader>ds")

-- Window  manager conflicts
nomap("n", "<A-v>")
nomap("n", "<A-h>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map({ "n" }, "<leader>tt", function()
  require("base46").toggle_theme()

  local bgUpdate = string.format("doautocmd %s", "ColorScheme")

  vim.cmd(bgUpdate)
end)

-- Buffers
nomap("n", "<leader>b")
map({ "n" }, "<leader>bn", "<cmd> enew <CR>", { desc = "buffer new" })

nomap("n", "<leader>x")
map({ "n", "t" }, "<C-x>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

map({ "n" }, "X", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "buffer close" })

-- Term

map("t", "<C-q>", "<C-\\><C-N>", { desc = "terminal escape" })

map({ "n" }, "<leader>th", function()
  require("nvchad.term").toggle { pos = "sp", id = "hToggleTerm" }
end, { desc = "terminal toggle horizontal" })

nomap("n", "<leader>v")
map({ "n" }, "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vToggleTerm" }
end, { desc = "terminal toggle vertical" })

map({ "n" }, "<leader>lg", function()
  require("nvchad.term").toggle {
    pos = "bo vsp",
    id = "lgToggleTerm",
    size = 0.9,
    cmd = "lazygit",
  }
end, { desc = "terminal toggle lazygit term" })

-- Tabs
map({ "n" }, "<leader>tn", "<cmd> tabnew <CR>")

map({ "n" }, "<leader>bh", function()
  require("nvchad.tabufline").move_buf(-1)
end, { desc = "buffer move left" })

map({ "n" }, "<leader>bl", function()
  require("nvchad.tabufline").move_buf(1)
end, { desc = "buffer move right" })

-- Telescope
map("n", "<leader>tr", "<cmd> Telescope resume <CR>", { desc = "telescope resume" })

map("n", "<leader>fs", "<cmd> Telescope session-lens <CR>", { desc = "telescope find sessions" })

map("n", "<leader>fq", "<cmd> Telescope quickfixhistory <CR>", { desc = "telescope quickfix" })

map("n", "<leader>fo", function()
  require("telescope.builtin").oldfiles {
    cwd_only = true,
    tiebreak = function(current_entry, existing_entry, _)
      -- This ensures that when you are filtering, it's also sorted by last opened time.
      -- https://github.com/nvim-telescope/telescope.nvim/issues/2539#issuecomment-1562510095
      return current_entry.index < existing_entry.index
    end,
  }
end, { desc = "telescope recent files" })

-- Oil
map({ "n" }, "<leader>e", "<cmd> Oil <CR>", { desc = "oil open" })

-- Harpoon
nomap("n", "<leader>h")

map({ "n" }, "<leader>hh", function()
  local harpoon = require "harpoon"
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "harpoon" })

map({ "n" }, "<leader>ha", function()
  require("harpoon"):list():add()
end, { desc = "harpoon add" })

map({ "n" }, "<leader>hn", function()
  require("harpoon"):list():next()
end, { desc = "harpoon next" })

map({ "n" }, "<leader>hp", function()
  require("harpoon"):list():prev()
end, { desc = "harpoon previous" })

for i = 1, 9 do
  map({ "n" }, "<leader>h" .. i, function()
    require("harpoon"):list():select(i)
  end, { desc = "harpoon select " .. i })
end

-- Autosession
map({ "n" }, "<leader>ss", "<cmd> SessionSave", { desc = "session save" })

-- NvimTree
nomap("n", "<C-n>")
