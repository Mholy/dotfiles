local function prettier()
  return { "prettier", stop_after_first = true }
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
    ["_"] = { "trim_whitespace" },
  },
}

return options
