-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "vtsls",
  "html",
  "cssls",
  "css_variables",
  "vuels",
  "typos_lsp",
  "tailwindcss",
}

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
    nvlsp.on_attach(client, bufnr)
  end,
  capabilities = nvlsp.capabilities,
  settings = {
    useESLintClass = true,
    codeActionOnSave = {
      enable = true,
      mode = "all",
    },
  },
}

lspconfig.cssmodules_ls.setup {
  on_attach = function(client)
    -- avoid accepting `definitionProvider` responses from this LSP
    client.server_capabilities.definitionProvider = false
    nvlsp.on_attach(client)
  end,
  capabilities = nvlsp.capabilities,
}
