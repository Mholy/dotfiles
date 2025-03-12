-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local map = vim.keymap.set

local servers = {
  "vtsls",
  "html",
  "cssls",
  "css_variables",
  "vuels",
  "typos_lsp",
  "tailwindcss",
  "graphql",
}

local nvlsp = require "nvchad.configs.lspconfig"

local function on_attach(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")

  map("n", "gs", "<cmd> Telescope lsp_document_symbols <CR>", opts "Symbols")
  map("n", "gS", "<cmd> Telescope lsp_workspace_symbols <CR>", opts "Workspace symbols")
  map("n", "gr", "<cmd> Telescope lsp_references <CR>", opts "References")
  map("n", "gd", "<cmd> Telescope lsp_definitions <CR>", opts "Definitions")
  map("n", "gD", "<cmd> Telescope lsp_type_definitions <CR>", opts "Type definitions")
  map("n", "go", "<cmd> Telescope lsp_outgoing_calls <CR>", opts "Outgoing calls")
  map("n", "gi", "<cmd> Telescope lsp_incoming_calls <CR>", opts "Incoming calls")
  map("n", "gI", "<cmd> Telescope lsp_implementations <CR>", opts "Implementations")
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
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
    on_attach(client, bufnr)
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
    on_attach(client)
  end,
  capabilities = nvlsp.capabilities,
}
