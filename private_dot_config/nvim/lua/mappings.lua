require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

-- General
nomap("n", "<C-s>")

-- navigation
nomap("i", "<C-j>")
nomap("i", "<C-k>")
nomap("i", "<C-h>")
nomap("i", "<C-l>")

nomap("n", "<C-n>") -- NvimTree
nomap("n", "<leader>b") -- buffer new
nomap("n", "<leader>h") -- Term
nomap("n", "<leader>v") -- Term

map({ "n", "i", "v" }, "<D-s>", "<cmd>w<CR>", { desc = "general save file" })
map({ "n" }, "<leader>tt", function()
  require("base46").toggle_theme()

  local bgUpdate = string.format("doautocmd %s", "ColorScheme")

  vim.cmd(bgUpdate)
end, { desc = "general light/dark" })

-- Buffers
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })

map({ "n" }, "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "buffer close all" })

map({ "n" }, "<leader>bt", "<cmd>tabnew<CR>", { desc = "buffer new tab" })

-- Terminal
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
end, { desc = "terminal toggle jjui" })

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

-- leap
map({ "n", "x", "o" }, "s", "<Plug>(leap)", { desc = "leap search" })
map("n", "S", "<Plug>(leap-from-window)", { desc = "leap search from window" })
map({ "x", "o" }, "R", function()
  require("leap.treesitter").select {
    -- to increase/decrease the selection in a clever-f-like manner,
    -- with the trigger key itself (vRRRRrr...). The default keys
    -- (<enter>/<backspace>) also work, so feel free to skip this.
    opts = require("leap.user").with_traversal_keys("R", "r"),
  }
end, { desc = "leap treesitter" })
