require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

-- General
nomap("n", "<C-s>")
map({ "n", "i", "v" }, "<D-s>", "<cmd>w<CR>", { desc = "general save file" })
map({ "n" }, "<leader>tt", function()
  require("base46").toggle_theme()

  local bgUpdate = string.format("doautocmd %s", "ColorScheme")

  vim.cmd(bgUpdate)
end, { desc = "general light/dark" })

-- Buffers
nomap("n", "<leader>b")
map("n", "<leader>bn", "<cmd>new<CR>", { desc = "buffer new" })
map({ "n" }, "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "buffer close all" })

map({ "n" }, "<leader>tn", "<cmd>tabnew<CR>", { desc = "buffer new tab" })

map({ "n" }, "<leader>bh", function()
  require("nvchad.tabufline").move_buf(-1)
end, { desc = "buffer move left" })

map({ "n" }, "<leader>bl", function()
  require("nvchad.tabufline").move_buf(1)
end, { desc = "buffer move right" })

-- Term
nomap("n", "<leader>h")
nomap("n", "<leader>v")

map({ "n" }, "<leader>th", function()
  require("nvchad.term").toggle { pos = "sp", id = "hToggleTerm" }
end, { desc = "terminal toggle horizontal" })

map({ "n" }, "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vToggleTerm" }
end, { desc = "terminal toggle vertical" })

map({ "n" }, "<leader>tg", function()
  require("nvchad.term").toggle {
    pos = "bo vsp",
    id = "lgToggleTerm",
    size = 0.9,
    cmd = "lazygit",
  }
end, { desc = "terminal toggle lazygit" })

map({ "n" }, "<leader>tj", function()
  require("nvchad.term").toggle {
    pos = "bo vsp",
    id = "lgToggleTerm",
    size = 0.9,
    cmd = "jjui",
  }
end, { desc = "terminal toggle lazygit" })

-- Telescope
map("n", "<leader>fr", "<cmd> Telescope resume <CR>", { desc = "telescope resume" })
map("n", "<leader>fs", "<cmd> Telescope session-lens <CR>", { desc = "telescope find sessions" })
map("n", "<leader>fq", "<cmd> Telescope quickfixhistory <CR>", { desc = "telescope quickfix" })
map("n", "<leader>ch", "<cmd> Telescope keymaps <CR>", { desc = "telescope keymaps" })

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

-- NvimTree
nomap("n", "<C-n>")

-- Codeium
map("i", "<C-CR>", function()
  require("neocodeium").accept()
end, { desc = "codeium accept" })
map("i", "<C-,>", function()
  require("neocodeium").accept_word()
end, { desc = "codeium accept word" })
map("i", "<C-.>", function()
  require("neocodeium").accept_line()
end, { desc = "codeium accept line" })
map("i", "<C-;>", function()
  require("neocodeium").cycle_or_complete()
end, { desc = "codeium complete/next" })
map("i", "<C-S-;>", function()
  require("neocodeium").cycle_or_complete(-1)
end, { desc = "codeium prev" })
map("i", "<C-\\>", function()
  require("neocodeium").clear()
end, { desc = "codeium clear" })

-- leap
map({ "n", "x", "o" }, "s", "<Plug>(leap)", { desc = 'leap search'})
map("n", "S", "<Plug>(leap-from-window)", { desc = 'leap search from window'})
map({ "x", "o" }, "R", function()
  require("leap.treesitter").select {
    -- to increase/decrease the selection in a clever-f-like manner,
    -- with the trigger key itself (vRRRRrr...). The default keys
    -- (<enter>/<backspace>) also work, so feel free to skip this.
    opts = require("leap.user").with_traversal_keys("R", "r"),
  }
end, { desc = 'leap treesitter'})
