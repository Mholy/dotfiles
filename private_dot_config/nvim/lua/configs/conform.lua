local function prettier()
  return { "prettier", stop_after_first = true }
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    ["_"] = function(bufnr)
      if require("conform").get_formatter_info("prettier", bufnr).available then
        return prettier()
      else
        return { "trim_whitespace" }
      end
    end,
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },
}

return options
