-- All NvChad plugins are lazy-loaded by default
-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
---@type NvPluginSpec[]
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
    dependencies = {
      {
        "yioneko/nvim-vtsls",
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua
        "lua-language-server",
        "stylua",

        -- web
        "html-lsp",
        "css-lsp",
        "css-variables-language-server",
        "cssmodules-language-server",
        "vtsls",
        "vue-language-server",
        "eslint-lsp",
        "prettier",
        "prettierd",

        "typos-lsp",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "vue",
        "markdown",
        "markdown_inline",
        "graphql",
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>", -- set to `false` to disable one of the mappings
          scope_incremental = "<C-CR>",
          node_incremental = "<CR>",
          node_decremental = "<S-CR>",
        },
      },
    },
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
          require("supermaven-nvim").setup {}
        end,
      },
    },
    config = function(_, opts)
      local cmp = require "cmp"

      opts.completion.autocomplete = false

      opts.mapping["<C-Space>"] = nil
      opts.mapping["<A-Space>"] = cmp.mapping.complete()
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { "i", "s" })

      cmp.setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "jvgrootveld/telescope-zoxide",
      },
    },
    opts = {
      extensions_list = { "zoxide" },
    },
    config = function(_, opts)
      local t = require "telescope"
      local z_utils = require "telescope._extensions.zoxide.utils"

      opts.extensions.zoxide = {
        prompt_title = "[ Zoxide ]",

        -- Zoxide list command with score
        list_command = "zoxide query -ls",

        mappings = {
          default = {
            action = function(selection)
              vim.cmd.edit(selection.path)
            end,
          },
          ["<C-s>"] = { action = z_utils.create_basic_command "split" },
          ["<C-v>"] = { action = z_utils.create_basic_command "vsplit" },
          ["<C-e>"] = { action = z_utils.create_basic_command "edit" },
          ["<C-t>"] = {
            action = function(selection)
              vim.cmd.tcd(selection.path)
            end,
          },
          ["<C-f>"] = {
            keepinsert = true,
            action = function(selection)
              t.builtin.find_files { cwd = selection.path }
            end,
          },
        },
      }

      t.setup(opts)
    end,
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

  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  {
    "danymat/neogen",
    event = "InsertEnter",
    config = function()
      require("neogen").setup {
        snippet_engine = "luasnip",
      }
    end,
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup {
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_use_git_branch = true,
      }
    end,
  },
}
