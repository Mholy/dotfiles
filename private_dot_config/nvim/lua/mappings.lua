require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

-- General
nomap("i", "<C-j>")
nomap("i", "<C-k>")
nomap("i", "<C-h>")
nomap("i", "<C-l>")

-- NvimTree
nomap("n", "<C-n>")

nomap("n", "<leader>b") -- buffer new
nomap("n", "<leader>x") -- buffer close
nomap("n", "<leader>h") -- Term
nomap("n", "<leader>v") -- Term

-- nomap("n", "<C-s>") -- save file
-- map({ "n", "i", "v" }, "<D-s>", "<cmd>w<CR>", { desc = "general save file" })

map({ "n" }, "<leader>tt", function()
  require("base46").toggle_theme()

  local bgUpdate = string.format("doautocmd %s", "ColorScheme")

  vim.cmd(bgUpdate)
end, { desc = "general light/dark" })

-- Buffers
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })
map({ "n" }, "<leader>bt", "<cmd>tabnew<CR>", { desc = "buffer new tab" })

map({ "n", "t" }, "<C-x>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close all" })

map({ "n" }, "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "buffer close all" })

-- Terminal
map("t", "<C-\\>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- Horizontal
map({ "n" }, "<leader>th", function()
  require("nvchad.term").toggle { pos = "sp", id = "hToggleTerm" }
end, { desc = "terminal toggle horizontal" })

-- Vertical
map({ "n" }, "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vToggleTerm" }
end, { desc = "terminal toggle vertical" })

-- Lazygit
map({ "n" }, "<leader>l", function()
  require("nvchad.term").toggle {
    pos = "bo sp",
    id = "lgToggleTerm",
    size = 1,
    cmd = "lazygit",
  }
end, { desc = "terminal toggle lazygit" })

-- jjui
map({ "n" }, "<leader>tj", function()
  require("nvchad.term").toggle {
    pos = "bo sp",
    id = "jjToggleTerm",
    size = 1,
    cmd = "unset DEBUG && jjui",
  }
end, { desc = "terminal toggle jjui" })

-- Claude Code
map({ "n" }, "<leader>cl", function()
  require("nvchad.term").toggle {
    pos = "bo sp",
    id = "claudeToggleTerm",
    size = 0.5,
    cmd = "claude",
  }
end, { desc = "terminal toggle claude" })

-- Markdown Preview
map({ "n" }, "<leader>md", function()
  require("nvchad.term").toggle {
    pos = "bo vsp",
    id = "glowToggleTerm",
    size = 0.5,
    cmd = "glow -p " .. vim.fn.shellescape(vim.fn.expand "%:p"),
  }
end, { desc = "markdown preview toggle" })

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

-- LSP
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code action" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "LSP Show signature help" })

map("n", "gs", function()
  require("telescope.builtin").lsp_document_symbols {
    ignore_symbols = {
      "property",
      "method",
    },
  }
end, { desc = "LSP Symbols" })

map("n", "gS", function()
  require("telescope.builtin").lsp_dynamic_workspace_symbols {
    ignore_symbols = {
      "property",
      "method",
    },
  }
end, { desc = "LSP Workspace symbols" })

map("n", "gr", "<cmd> Telescope lsp_references <CR>", { desc = "LSP Incoming calls" })
map("n", "go", "<cmd> Telescope lsp_outgoing_calls <CR>", { desc = "LSP Outgoing calls" })
map("n", "gi", "<cmd> Telescope lsp_incoming_calls <CR>", { desc = "LSP Incoming calls" })

-- autocmds
map({ "n", "v" }, "<leader>ai", ":CopyContext<CR>", { desc = "Copy Context for AI" })
