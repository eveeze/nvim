-- lua/plugins/core/lsp/mason-general-installer.lua
-- return {
--   "WhoIsSethDaniel/mason-tool-installer.nvim",
--   opts = function()
--     require('mason-tool-installer').setup {
--
--       -- a list of all tools you want to ensure are installed upon
--       -- start
--       ensure_installed = require("plugins.core.setup-sources").mason_general_packages,
--
--       -- if set to true this will check each tool for updates. If updates
--       -- are available the tool will be updated. This setting does not
--       -- affect :MasonToolsUpdate or :MasonToolsInstall.
--       -- Default: false
--       auto_update = false,
--
--       -- automatically install / update on startup. If set to false nothing
--       -- will happen on startup. You can use :MasonToolsInstall or
--       -- :MasonToolsUpdate to install tools and check for updates.
--       -- Default: true
--       run_on_start = true,
--     }
--   end
-- }
-- versi2
-- return {
--   "WhoIsSethDaniel/mason-tool-installer.nvim",
--   dependencies = {
--     "williamboman/mason.nvim",
--     "williamboman/mason-lspconfig.nvim" -- Tambahkan dependency
--   },
--   opts = function()
--     require('mason-tool-installer').setup({
--       ensure_installed = require("plugins.core.setup-sources").mason_general_packages,
--       auto_update = false,
--       run_on_start = true,
--
--       -- Tambahkan integrasi dengan LSP
--       integrations = {
--         ["mason-lspconfig"] = true
--       }
--     })
--   end
-- }
-- versi 3
-- lua/plugins/core/lsp/mason-general-installer.lua
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim"
  },
  config = function()
    require('mason-tool-installer').setup({
      ensure_installed = require("plugins.core.setup-sources").mason_general_packages,
      auto_update = false,
      run_on_start = true,
      integrations = {
        ["mason-lspconfig"] = true
      }
    })
  end
}
