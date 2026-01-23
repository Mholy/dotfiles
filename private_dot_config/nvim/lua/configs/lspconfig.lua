-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local map = vim.keymap.set

local M = {}

-- copy from nvchad config
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")

  map("n", "gs", function()
    require("telescope.builtin").lsp_document_symbols {
      ignore_symbols = {
        "property",
        "method",
      },
    }
  end, opts "Symbols")
  map("n", "gS", function()
    require("telescope.builtin").lsp_dynamic_workspace_symbols {
      ignore_symbols = {
        "property",
        "method",
      },
    }
  end, opts "Workspace symbols")
  map("n", "gr", "<cmd> Telescope lsp_references <CR>", opts "References")
  map("n", "go", "<cmd> Telescope lsp_outgoing_calls <CR>", opts "Outgoing calls")
  map("n", "gi", "<cmd> Telescope lsp_incoming_calls <CR>", opts "Incoming calls")
  map("n", "gI", "<cmd> Telescope lsp_implementations <CR>", opts "Implementations")
end

M.servers = {
  "html",
  "cssls",
  "css_variables",
  "cssmodules_ls",
  "vtsls",
  "eslint",
  "tailwindcss",
  "graphql",
  "typos_lsp",
  "gh_actions_ls",
}

local eslint_onattach = vim.lsp.config.eslint.on_attach
vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    if not eslint_onattach then
      return
    end

    eslint_onattach(client, bufnr)

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "LspEslintFixAll",
    })
  end,
  settings = {
    useESLintClass = true,
  },
})

local cssmodules_onattach = vim.lsp.config.cssmodules_ls.on_attach
vim.lsp.config("cssmodules_ls", {
  on_attach = function(client, bufnr)
    if not cssmodules_onattach then
      return
    end

    cssmodules_onattach(client, bufnr)

    -- avoid accepting `definitionProvider` responses from this LSP
    client.server_capabilities.definitionProvider = false
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    M.on_attach(_, args.buf)
  end,
})

vim.lsp.enable(M.servers)
