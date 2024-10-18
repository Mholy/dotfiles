-- All NvChad plugins are lazy-loaded by default
-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example

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
        config = function()
          require("treesitter-context").setup {
            multiline_threshold = 3,
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
            disable_inline_completion = true,
            disable_keymaps = true,
          }
        end,
      },
    },
    config = function(_, opts)
      local cmp = require "cmp"

      -- opts.completion.autocomplete = false

      opts.mapping["<C-Space>"] = nil
      opts.mapping["<A-Space>"] = cmp.mapping.complete()
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require "luasnip"
        local suggestion = require "supermaven-nvim.completion_preview"

        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif suggestion.has_suggestion() then
          suggestion.on_accept_suggestion()
        else
          fallback()
        end
      end, { "i", "s" })

      table.insert(opts.sources, 1, { name = "supermaven" })

      cmp.setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },

  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("oil").setup {
        skip_confirm_for_simple_edits = true,
        keymaps = {
          ["q"] = "actions.close",
          ["<C-c>"] = false,
          ["<C-s>"] = false,
          ["<C-h>"] = false,
          ["g\\"] = false,
          ["gY"] = "actions.copy_entry_path",
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
          local cmd = "git rev-parse --is-inside-work-tree"
          return vim.fn.system(cmd) == "true\n"
        end,
      }
    end,
  },

  { "typicode/bg.nvim", lazy = false },
}
