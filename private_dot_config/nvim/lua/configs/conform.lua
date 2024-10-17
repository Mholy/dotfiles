---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require "conform"
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

---@param bufnr integer
local function prettier(bufnr)
  return { first(bufnr, "prettierd", "prettier"), "injected" }
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = prettier,
    typescript = prettier,
    javascriptreact = prettier,
    typescriptreact = prettier,
    html = prettier,
    css = prettier,
    scss = prettier,
    json = prettier,
    yaml = prettier,
    yml = prettier,
    markdown = prettier,
    markdown_inline = prettier,
    graphql = prettier,
    ["*"] = { "codespell" },
  },

  -- formatters = {
  --   injected = {
  --     lang_to_ext = {
  --       css = "css",
  --       html = "html",
  --       javascript = "js",
  --     },
  --   },
  -- },
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
