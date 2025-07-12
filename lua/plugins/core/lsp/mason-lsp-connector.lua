-- mason-lspconfig bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins together.
-- lua/plugins/core/lsp/mason-lsp-connector.lua
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not ok then
      vim.notify("mason-lspconfig not found", vim.log.levels.WARN)
      return
    end

    mason_lspconfig.setup({
      ensure_installed = require("plugins.core.setup-sources").mason_lsps,
      automatic_installation = true,
    })

    -- Setup handlers for automatic configuration
    mason_lspconfig.setup_handlers({
      -- Default handler for all servers
      function(server_name)
        local ok_lsp, lspconfig = pcall(require, "lspconfig")
        if not ok_lsp then
          return
        end

        -- Basic setup for all servers
        lspconfig[server_name].setup({})
      end,
    })
  end,
}
