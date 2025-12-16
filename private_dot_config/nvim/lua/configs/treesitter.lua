local options = {}

options.ensure_installed = {
  "vim",
  "lua",
  "vimdoc",
  "html",
  "css",
  "scss",
  "styled",
  "javascript",
  "typescript",
  "tsx",
  "vue",
  "jsdoc",
  "markdown",
  "markdown_inline",
  "graphql",
  "diff",
  "json",
  "yaml",
  "just"
}

options.indent = {
  enable = true,
}

-- switched to leap
-- options.incremental_selection = {
--   enable = true,
--   keymaps = {
--     -- set to `false` to disable one of the mappings
--     init_selection = "<C-CR>",
--     scope_incremental = "<C-S-CR>",
--     node_incremental = "<C-CR>",
--     node_decremental = "<S-CR>",
--   },
-- }

return options
