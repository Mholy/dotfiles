require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

nomap("n", "<leader>b")
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap("n", "<C-n>")
nomap("n", "<A-v>")
nomap("n", "<A-h>")

-- Old mapping syntax

local M = {}

M.general = {
  n = {
    ["<leader>bn"] = { "<cmd> new <CR>", "New buffer" },
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>tt"] = {
      function()
        require("base46").toggle_theme()
        local bgUpdate = string.format("doautocmd %s", "ColorScheme")
        vim.cmd(bgUpdate)
      end,
      "Toggle theme",
    },
  },
}

M.buffer = {
  n = {
    ["<leader>X"] = {
      function()
        require("nvchad.tabufline").closeAllBufs()
      end,
      "Close all",
    },
  },
}

M.tabufline = {
  n = {
    -- ["<leader>bl"] = { "<cmd> BufMoveRight <CR>", "Move buffer right" },
    -- ["<leader>bh"] = { "<cmd> BufMoveLeft <CR>", "Move buffer left" },
    ["<leader>bl"] = {
      function()
        require("nvchad.tabufline").move_buf(1)
      end,
      "Move buffer right",
    },
    ["<leader>bh"] = {
      function()
        require("nvchad.tabufline").move_buf(-1)
      end,
      "Move buffer left",
    },
  },
}

M.oil = {
  n = {
    ["<leader>e"] = { "<cmd> Oil <CR>", "Open oil" },
  },
}

M.harpoon = {
  n = {
    ["<leader>hh"] = {
      function()
        local harpoon = require "harpoon"

        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      "Harpooned",
    },
    ["<leader>ha"] = {
      function()
        require("harpoon"):list():add()
      end,
      "Harpoon",
    },
    ["<leader>hn"] = {
      function()
        require("harpoon"):list():next()
      end,
      "Next harpooned",
    },
    ["<leader>hp"] = {
      function()
        require("harpoon"):list():prev()
      end,
      "Previous harpooned",
    },
  },
}

for i = 1, 9 do
  M.harpoon.n["<leader>h" .. i] = {
    function()
      require("harpoon"):list():select(i)
    end,
    i .. " harpooned",
  }
end

M.autosession = {
  n = {
    ["<leader>ss"] = { ":SessionSave ", "Save session" },
  },
}

for group, modes in pairs(M) do
  for mode, maps in pairs(modes) do
    for key, val in pairs(maps) do
      map(mode, key, val[1], { desc = group .. " " .. val[2] })
    end
  end
end

-- New mapping syntax

-- Term
map("t", "<C-q>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "terminal close" })

map({ "n" }, "<leader>th", function()
  require("nvchad.term").toggle { pos = "sp", id = "hToggleTerm" }
end, { desc = "Terminal toggle horizontal" })

map({ "n" }, "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vToggleTerm" }
end, { desc = "Terminal toggle vertical" })

map({ "n" }, "<leader>lg", function()
  require("nvchad.term").toggle {
    pos = "vsp",
    id = "lgToggleTerm",
    size = 0.9,
    cmd = "lazygit",
  }
end, { desc = "Terminal toggle lazygit term" })

-- Git
map({ "n" }, "]c", function()
  require("gitsigns").next_hunk()
end, { desc = "Git next hunk" })

map({ "n" }, "[c", function()
  require("gitsigns").prev_hunk()
end, { desc = "Git nrev hunk" })

-- Telescope
map({ "n" }, "<leader>sl", "<cmd> Telescope session-lens <CR>", { desc = "Telescope find sessions" })
map({ "n" }, "<leader>fr", "<cmd> Telescope resume <CR>", { desc = "Telescope resume" })
