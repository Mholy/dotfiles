require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",

  "eslint",

  "cssls",
  "css_variables",
  "cssmodules_ls",
  "tailwindcss",

  "graphql",

  -- "yamlls",

  -- "ansiblels",

  "typos_lsp",
}

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

vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      classFunctions = { "tw", "clsx", "tw\\.[a-z-]+", "cva" },
      includeLanguages = {
        eelixir = "html-eex",
        elixir = "phoenix-heex",
        eruby = "erb",
        heex = "phoenix-heex",
        htmlangular = "html",
        templ = "html",
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
})

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

vim.lsp.enable(servers)
