local prettier = { "prettierd", "prettier", stop_after_first = true }

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
    markdown = prettier,
    markdown_inline = prettier,
    graphql = prettier,
    ["*"] = { "codespell" },
  },

  formatters = {
    injected = {
      lang_to_ext = {
        css = "css",
      },
    },
  },
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
