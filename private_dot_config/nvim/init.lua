vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

vim.filetype.add {
  pattern = {
    -- Give the proper file type to ansible yaml configuration files.
    -- This depends on the LSP config: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ansiblels
    [".*ya?ml"] = function(path, _)
      local ansible_patterns = { "ansible.cfg", "inventory.ini", "inventory.yaml", "inventory.yml" }
      local ansible_cfg = vim.fs.find(ansible_patterns, { upward = true, type = "file", path = path })
      -- print(vim.inspect(ansible_cfg))

      return vim.tbl_isempty(ansible_cfg) and "yaml" or "yaml.ansible"
    end,
  },
}

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
