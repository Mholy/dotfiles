# Neovim Config (NvChad-based)

## Stack

- **Plugin manager**: lazy.nvim (bootstrapped in `init.lua`)
- **Framework**: NvChad v2.5 (`NvChad/NvChad` on branch `v2.5`)
- **Formatter**: stylua (`.stylua.toml`: 120 cols, 2-space indent, double quotes)

## File structure

```
init.lua              # bootstrap lazy.nvim, load nvchad + plugins
lua/
  chadrc.lua          # NvChad UI/LSP/term config
  highlights.lua      # custom theme overrides
  autocmds.lua        # autocommands
  options.lua         # vim.o settings
  mappings.lua        # keymaps
  configs/
    lazy.lua          # lazy.nvim config
    conform.lua       # conform.nvim formatter config
    lspconfig.lua     # LSP setup
    treesitter.lua    # treesitter config
  plugins/init.lua    # plugin specs (lazy-loaded by default)
  utils/workmode.lua  # work project detection (used by copilot.lua condition)
```

## Plugin quirks

- **lazy loading**: plugins load on `ft`, `cmd`, `keys`, `event`, or `lazy = false`. Add `lazy = false` to load at startup.
- **nvim-tree.lua**: disabled in `lua/plugins/init.lua`
- **copilot.lua**: conditionally enabled via `utils.workmode.is_work_project()`
- **neocodeium**: disabled by default; `<C-l>` accept, `<C-,>` accept word, `<C-.>` accept line

## Custom filetype detection

Ansible YAML files (`.yml`/`.yaml`) get `yaml.ansible` ft if `ansible.cfg`, `inventory.ini`, `inventory.yaml`, or `inventory.yml` found in parent directories.
