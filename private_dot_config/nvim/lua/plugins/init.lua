-- All NvChad plugins are lazy-loaded by default
-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example

local function isGitDirectory()
  local cmd = "git rev-parse --is-inside-work-tree"
  return vim.fn.system(cmd) == "true\n"
end

---@type NvPluginSpec[]
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
    dependencies = {
      {
        "yioneko/nvim-vtsls",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        enabled = false,
        config = function()
          require("treesitter-context").setup {
            multiline_threshold = 1,
            -- separator = "-",
          }
        end,
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "supermaven-inc/supermaven-nvim",
        config = function()
          require("supermaven-nvim").setup {
            -- disable_inline_completion = true,
            -- disable_keymaps = true,
            condition = function()
              return not isGitDirectory()
            end,
          }
        end,
      },
    },
    config = function(_, opts)
      local cmp = require "cmp"

      -- opts.completion.autocomplete = false

      opts.mapping["<C-Space>"] = nil
      opts.mapping["<A-Space>"] = cmp.mapping.complete()
      opts.mapping["<Tab>"] = nil
      opts.mapping["<S-Tab>"] = nil

      -- table.insert(opts.sources, 1, { name = "supermaven" })

      cmp.setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function(_, opts)
      opts.on_attach = function(bufnr)
        local gitsigns = require "gitsigns"

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end, { desc = "git next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end, { desc = "git prev hunk" })

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git stage hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git reset hunk" })
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { desc = "git stage hunk range" })
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { desc = "git reset hunk range" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git stage buffer" })
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "git undo stage hunk" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git reset buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git preview hunk" })
        map("n", "<leader>hb", function()
          gitsigns.blame_line { full = true }
        end, { desc = "git blame line" })
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "git toggle current line blame" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "git diff this" })
        map("n", "<leader>hD", function()
          gitsigns.diffthis "~"
        end, { desc = "git diff this ~" })
        map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "git toggle deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "git select hunk" })
      end

      require("gitsigns").setup(opts)
    end,
  },

  {
    "telescope.nvim",
    config = function(_, opts)
      -- local open_with_trouble = require("trouble.sources.telescope").open

      -- Use this to add more results without clearing the trouble list
      -- local add_to_trouble = require("trouble.sources.telescope").add

      -- opts.defaults.mappings = {
      --   i = { ["<c-t>"] = open_with_trouble, ["<s-t>"] = add_to_trouble },
      --   n = { ["<c-t>"] = open_with_trouble, ["<s-t>"] = add_to_trouble },
      -- }

      require("telescope").setup(opts)
    end,
  },

  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("oil").setup {
        skip_confirm_for_simple_edits = true,
        use_default_keymaps = false,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
          ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
          ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
          ["<C-p>"] = "actions.preview",
          ["<C-d>"] = "actions.preview_scroll_down",
          ["<C-u>"] = "actions.preview_scroll_up",
          ["q"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["<C-\\>"] = {
            function()
              require("oil").discard_all_changes()
            end,
            desc = "Discard all changes",
          },
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
          ["gs"] = "actions.change_sort",
          ["g."] = "actions.toggle_hidden",
          ["gY"] = "actions.yank_entry",
          ["gy"] = {
            function()
              local oil = require "oil"
              local entry = oil.get_cursor_entry()
              local dir = oil.get_current_dir()
              local git_root = vim.fn.system "git rev-parse --show-toplevel"
              git_root = git_root:gsub("\n", "") -- Remove newline character from the output
              local Path = require "plenary.path"
              local relative_path = Path:new(dir):make_relative(git_root)

              if not relative_path then
                return
              end

              vim.fn.setreg("+", relative_path .. "/" .. entry.name)
            end,
            desc = "Copy the relative filepath of the entry under the cursor to the + register",
          },
        },
        float = {
          border = "single",
        },
      }
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
      require("harpoon").setup()
    end,
  },

  -- {
  --   "wakatime/vim-wakatime",
  --   lazy = false,
  -- },

  -- {
  --   "danymat/neogen",
  --   event = "InsertEnter",
  --   config = function()
  --     require("neogen").setup {
  --       snippet_engine = "luasnip",
  --     }
  --   end,
  -- },

  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup {
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_use_git_branch = false,
        auto_create = function()
          return isGitDirectory()
        end,
      }
    end,
  },

  { "typicode/bg.nvim", lazy = false },

  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      vim.keymap.set("n", "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
      vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")

      -- Define equivalence classes for brackets and quotes, in addition to
      -- the default whitespace group.
      require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

      -- Use the traversal keys to repeat the previous motion without explicitly
      -- invoking Leap.
      require("leap.user").set_repeat_keys("<enter>", "<backspace>")
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
  },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    config = function()
      require("todo-comments").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    enabled = false,
    opts = {
      auto_jump = true, -- auto jump to the item when there's only one
      focus = true, -- Focus the window when opened
      ---@type trouble.Window.opts
      win = {
        size = 0.3,
      },
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xt",
        "<cmd>Trouble todo filter = {tag = {TODO,FIX,FIXME}}<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "gs",
        "<cmd>Trouble symbols toggle focus=false win.relative=win win.position=right pinned=true<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "gd",
        "<cmd>Trouble lsp toggle win.position=right follow=false<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    event = "BufRead",
    opts = {
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
    },
  },
}
