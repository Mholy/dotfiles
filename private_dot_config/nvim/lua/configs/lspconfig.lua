-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

local servers = {
  "vtsls",
  "html",
  "cssls",
  "css_variables",
  "vuels",
  "typos_lsp",
  "tailwindcss",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
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
    on_attach(client)
  end,
  capabilities = capabilities,
}

lspconfig.graphql.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "graphql", "typescriptreact", "javascriptreact", "javascript", "typescript" },
}

-- lspconfig.vtsls.setup({
-- on_attach = function(client)
--   vim.lsp.inlay_hint.enable()
--   vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
--     local locations = command.arguments[3]
--     if locations and #locations > 0 then
--       local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
--       vim.fn.setloclist(0, {}, " ", { title = "References", items = items, context = ctx })
--       vim.api.nvim_command("lopen")
--     end
--   end
-- end,
-- capabilities = capabilities,
-- settings = {
--   typescript = {
--     inlayHints = {
--       parameterNames = { enabled = "literals" },
--       parameterTypes = { enabled = true },
--       variableTypes = { enabled = true },
--       propertyDeclarationTypes = { enabled = true },
--       functionLikeReturnTypes = { enabled = true },
--       enumMemberValues = { enabled = true },
--     },
-- referencesCodeLens = {
--   enabled = true,
--   showOnAllFunctions = true,
-- },
-- implementationsCodeLens = {
--   enabled = true,
--   showOnInterfaceMethods = true,
-- },
--   },
-- },
-- })
