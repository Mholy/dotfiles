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
    ["<leader>e"] = { "<cmd> Oil --float <CR>", "Open floating oil" },
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

M.telescope = {
  n = {
    ["<leader>sl"] = { "<cmd> Telescope session-lens <CR>", "Find sessions" },
    ["<leader>z"] = { "<cmd> Telescope zoxide list <CR>", "Find files" },
  },
}

M.autosession = {
  n = {
    ["<leader>ss"] = { ":SessionSave ", "Save session" },
  },
}

M.terminal = {
  n = {
    ["<leader>lg"] = {
      function()
        require("nvchad.term").toggle {
          pos = "float",
          id = "lazyGitTerm",
          cmd = "lazygit",
        }
      end,
      "Lazygit",
    },
    ["<leader>th"] = {
      function()
        require("nvchad.term").new { pos = "sp" }
      end,
      "New horizontal",
    },
    ["<leader>tv"] = {
      function()
        require("nvchad.term").new { pos = "vsp" }
      end,
      "New vertical",
    },
  },
}

for group, modes in pairs(M) do
  for mode, maps in pairs(modes) do
    for key, val in pairs(maps) do
      map(mode, key, val[1], { desc = group .. " " .. val[2] })
    end
  end
end
