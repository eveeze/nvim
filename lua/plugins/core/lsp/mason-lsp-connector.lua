-- maosn-lsp-connector
-- return {
--   "williamboman/mason-lspconfig.nvim",
--   opts = function()
--     require("mason-lspconfig").setup({
--       ensure_installed = require("plugins.core.setup-sources").mason_lsps,
--     })
--   end,
-- }
--
-- lua/plugins/core/lsp/mason-lsp-connector.lua
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig"
  },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = require("plugins.core.setup-sources").mason_lsps,
      automatic_installation = true,
      -- This will automatically setup LSP servers installed by mason
      handlers = {
        -- Default handler (optional, will be called for each server without a custom handler)
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities()
          })
        end,
        -- Custom handlers for specific servers
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }
                }
              }
            }
          })
        end,
      }
    })
  end,
}
