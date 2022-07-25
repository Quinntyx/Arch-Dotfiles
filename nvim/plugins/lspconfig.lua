local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  local servers = {
    "html",
    "cssls",
    "clangd",
    "angularls",
    "dockerls",
    "golangci_lint_ls",
    "jdtls",
    "jsonls",
    "kotlin_language_server",
    "marksman",
    "pyright",
    "rome",
    "rust_analyzer",
    "ltex",
    "cmake",
    "emmet_ls",
    "bashls"
  }

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }


  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
    }
  end
end

return M
