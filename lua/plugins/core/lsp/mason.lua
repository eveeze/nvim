-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
-- Mason is a plugin for installing a bunch of tools including language servers, formatters, linters, debuggers, etc.
-- lua/plugins/core/lsp/mason.lua
return {
  "williamboman/mason.nvim",
  lazy = false,
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "(v)",
          package_pending = "...",
          package_uninstalled = "(x)",
        },
      },
    })
  end,
}
